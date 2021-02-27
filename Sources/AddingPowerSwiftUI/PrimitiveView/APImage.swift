//
//  APImage.swift
//  
//
//  Created by Xuan Li on 2/22/21.
//

import SwiftUI

// MARK: - APImage

@frozen public struct APImage: Equatable {
    var provider: AnyImageProviderBox
    public static func == (lhs: APImage, rhs: APImage) -> Bool {
        lhs.provider.isEqual(rhs.provider)
    }
}

extension APImage {
    public init(systemName: String) {
        provider = ImageProviderBox(NamedImageProvider(systemName: systemName))
    }
    
    public init(_ name: String, bundle: Bundle? = nil) {
        provider = ImageProviderBox(NamedImageProvider(name, bundle: bundle))
    }
    
    public init(_ name: String, bundle: Bundle? = nil, label: Text) {
        provider = ImageProviderBox(NamedImageProvider(name, bundle: bundle, label: label))
    }
    
    public init(decorative name: String, bundle: Bundle? = nil) {
        provider = ImageProviderBox(NamedImageProvider(decorative: name, bundle: bundle))
    }
    
    public init(uiImage: UIImage) {
        provider = ImageProviderBox(uiImage)
    }
    
    public init(_ cgImage: CGImage, scale: CGFloat, orientation: Image.Orientation = .up, label: Text) {
        provider = ImageProviderBox(CGImageProvider(cgImage, scale: scale, orientation: orientation, label: label))
    }
    
    public init(decorative cgImage: CGImage, scale: CGFloat, orientation: Image.Orientation = .up) {
        provider = ImageProviderBox(CGImageProvider(decorative: cgImage, scale: scale, orientation: orientation))
    }
    
    init<Provider: ImageProvider>(_ provider: Provider) {
        self.provider = ImageProviderBox(provider)
    }
}

extension APImage {
    func resizable(capInsets: EdgeInsets = EdgeInsets(), resizingMode: Image.ResizingMode = .stretch) -> APImage {
        .init(ResizableProvider(self, capInsets: capInsets, resizingMode: resizingMode))
    }
    
    func renderingMode(_ renderingMode: Image.TemplateRenderingMode?) -> APImage {
        .init(RenderingModeProvider(self, renderingMode: renderingMode))
    }
    
    func interpolation(_ interpolation: Image.Interpolation) -> APImage {
        .init(InterpolationProvider(self, interpolation: interpolation))
    }
    
    func antialiased(_ isAntialiased: Bool) -> APImage {
        .init(AntialiasedProvider(self, isAntialiased: isAntialiased))
    }
}

extension APImage: View {
    public var body: Image {
        provider.asImage()
    }
}

extension APImage {
    public func asUIImage() -> UIImage? {
        provider.asUIImage()
    }
}

// MARK: - ImageProvider

protocol ImageProvider: Equatable {
    func asImage() -> Image
    func asUIImage() -> UIImage?
}

// MARK: - NamedImageProvider

extension APImage {
    struct NamedImageProvider: ImageProvider {
        var name: String
        var location: Location
        var backupLocation: Location?
        var label: Text?
        var decorative: Bool
        
        init(systemName: String) {
            name = systemName
            location = .system
            backupLocation = nil
            label = Text(verbatim: systemName)
            decorative = false
        }
        
        init(_ name: String, bundle: Bundle? = nil) {
            self.name = name
            location = .bundle(bundle ?? Bundle.main)
            backupLocation = nil
            label = Text(name)
            decorative = false
        }
        
        init(_ name: String, bundle: Bundle? = nil, label: Text? = nil) {
            self.name = name
            location = .bundle(bundle ?? Bundle.main)
            backupLocation = nil
            self.label = label
            decorative = false
        }
        
        init(decorative name: String, bundle: Bundle? = nil, label: Text? = nil) {
            self.name = name
            location = .bundle(bundle ?? Bundle.main)
            backupLocation = nil
            self.label = label
            decorative = true
        }
        
        func asImage() -> Image {
            switch location {
            case .system:
                return Image(systemName: name)
            case .bundle(let b):
                if decorative {
                    return Image(decorative: name, bundle: b)
                }
                if let l = label {
                    return Image(name, bundle: b, label: l)
                }
                return Image(name, bundle: b)
            }
        }
        
        func asUIImage() -> UIImage? {
            switch location {
            case .system:
                return UIImage(systemName: name)
            case .bundle(let b):
                if decorative {
                    return UIImage(named: name, in: b, with: nil)
                }
                let image = UIImage(named: name, in: b, with: nil)
                image?.isAccessibilityElement = true
                if let l = label {
                    //                    FIXME:
                    //                    image?.accessibilityLabel
                }
                return image
            }
        }
    }
    
    enum Location: Equatable {
        case system
        case bundle(Bundle)
    }
}

// MARK: - CGImageProvider

extension APImage {
    struct CGImageProvider: ImageProvider {
        var image: CGImage
        var scale: CGFloat
        var orientation: Image.Orientation
        var label: Text?
        var decorative: Bool
        
        init(_ cgImage: CGImage, scale: CGFloat, orientation: Image.Orientation = .up, label: Text? = nil) {
            image = cgImage
            self.scale = scale
            self.orientation = orientation
            self.label = label
            decorative = false
        }
        
        init(decorative cgImage: CGImage, scale: CGFloat, orientation: Image.Orientation = .up, label: Text? = nil) {
            image = cgImage
            self.scale = scale
            self.orientation = orientation
            self.label = label
            decorative = true
        }
        
        func asImage() -> Image {
            if let l = label {
                return Image(image, scale: scale, orientation: orientation, label: l)
            }
            return Image(decorative: image, scale: scale, orientation: orientation)
        }
        
        func asUIImage() -> UIImage? {
            let o: UIImage.Orientation
            switch orientation {
            case .up:
                o = .up
            case .down:
                o = .down
            case .left:
                o = .left
            case .right:
                o = .right
            case .upMirrored:
                o = .upMirrored
            case .downMirrored:
                o = .downMirrored
            case .leftMirrored:
                o = .leftMirrored
            case .rightMirrored:
                o = .rightMirrored
            }
            let uiImage = UIImage(cgImage: image, scale: scale, orientation: o)
            if decorative {
                return uiImage
            }
            uiImage.isAccessibilityElement = true
            if let l = label {
                //                    FIXME:
                //                    uiImage.accessibilityLabel
            }
            return uiImage
        }
    }
}

// MARK: - UIImage Provider

extension UIImage: ImageProvider {
    func asImage() -> Image {
        Image(uiImage: self)
    }
    
    func asUIImage() -> UIImage? {
        return self
    }
}

// MARK: - AntialiasedProvider

extension APImage {
    struct AntialiasedProvider: ImageProvider {
        var base: APImage
        var isAntialiased: Bool
        
        init(_ base: APImage, isAntialiased: Bool) {
            self.base = base
            self.isAntialiased = isAntialiased
        }
        
        func asImage() -> Image {
            base.provider.asImage()
                .antialiased(isAntialiased)
        }
        
        func asUIImage() -> UIImage? {
            let uiImage = base.asUIImage()
            return uiImage
        }
    }
}

// MARK: - InterpolationProvider

extension APImage {
    struct InterpolationProvider: ImageProvider {
        var base: APImage
        var interpolation: Image.Interpolation
        
        init(_ base: APImage, interpolation: Image.Interpolation) {
            self.base = base
            self.interpolation = interpolation
        }
        
        func asImage() -> Image {
            base.provider.asImage()
                .interpolation(interpolation)
        }
        
        func asUIImage() -> UIImage? {
            let uiImage = base.asUIImage()
            return uiImage
        }
    }
}

// MARK: - RenderingModeProvider

extension APImage {
    struct RenderingModeProvider: ImageProvider {
        var base: APImage
        var renderingMode: Image.TemplateRenderingMode?
        
        init(_ base: APImage, renderingMode: Image.TemplateRenderingMode?) {
            self.base = base
            self.renderingMode = renderingMode
        }
        
        func asImage() -> Image {
            base.provider.asImage()
                .renderingMode(renderingMode)
        }
        
        func asUIImage() -> UIImage? {
            let uiImage = base.asUIImage()
            if let rm = renderingMode {
                switch rm {
                case .original:
                    uiImage?.withRenderingMode(.alwaysOriginal)
                case .template:
                    uiImage?.withRenderingMode(.alwaysTemplate)
                @unknown default:
                    uiImage?.withRenderingMode(.automatic)
                }
            }
            return uiImage
        }
    }
}

// MARK: - ResizableProvider

extension APImage {
    struct ResizableProvider: ImageProvider {
        var base: APImage
        var capInsets: EdgeInsets
        var resizingMode: Image.ResizingMode
        
        init(_ base: APImage, capInsets: EdgeInsets = EdgeInsets(), resizingMode: Image.ResizingMode = .stretch) {
            self.base = base
            self.capInsets = capInsets
            self.resizingMode = resizingMode
        }
        
        func asImage() -> Image {
            base.provider.asImage()
                .resizable(capInsets: capInsets, resizingMode: resizingMode)
        }
        
        func asUIImage() -> UIImage? {
            let uiImage = base.asUIImage()
            let rm: UIImage.ResizingMode
            switch resizingMode {
            case .tile:
                rm = .tile
            case .stretch:
                rm = .stretch
            @unknown default:
                rm = .stretch
            }
            uiImage?.resizableImage(withCapInsets: UIEdgeInsets(top: capInsets.top, left: capInsets.leading, bottom: capInsets.bottom, right: capInsets.trailing), resizingMode: rm)
            return uiImage
            
        }
    }
}

// MARK: - AnyImageProviderBox

@usableFromInline
class AnyImageProviderBox {
    func isEqual(_ box: AnyImageProviderBox) -> Bool {
        fatalError("AnyImageProviderBox: base class is not implemented.")
    }
    
    func asImage() -> Image {
        fatalError("AnyImageProviderBox: base class is not implemented.")
    }
    
    func asUIImage() -> UIImage? {
        fatalError("AnyImageProviderBox: base class is not implemented.")
    }
}

// MARK: - ImageProviderBox

class ImageProviderBox<Base: ImageProvider>: AnyImageProviderBox {
    var base: Base
    
    init(_ base: Base) {
        self.base = base
    }
    
    override func isEqual(_ box: AnyImageProviderBox) -> Bool {
        if let sbox = box as? ImageProviderBox<Base> {
            return base == sbox.base
        }
        return false
    }
    
    override func asImage() -> Image {
        base.asImage()
    }
    
    override func asUIImage() -> UIImage? {
        base.asUIImage()
    }
}
