//
// Layout.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// Layouts allow you to have complete control over the HTML used to generate
/// your pages.
///
/// Example:
/// ```swift
/// struct BlogLayout: Layout {
///     var body: some Document {
///         Body {
///             content
///             Footer()
///         }
///     }
/// }
/// ```
@MainActor
public protocol Layout {
    /// The type of Document content this element contains.
    associatedtype Content: Document
    /// The main content of the layout.
    @DocumentBuilder var body: Content { get }
}

public extension Layout {
    /// The current page being rendered.
    var content: some HTML {
        EmptySection(PublishingContext.shared.environment.pageContent)
    }
}

public struct EmptySection: HTML, FormItem {
    /// The content and behavior of this HTML.
    public var body: some HTML { self }
    
    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()
    
    /// Whether this HTML belongs to the framework.
    public var isPrimitive: Bool { true }
   
    var content: any BodyElement
    
    init(_ content: any BodyElement) {
        self.content = content
    }
    
    /// Creates a section that renders as a `div` element.
    /// - Parameter content: The content to display within this section.
    public init(
        @HTMLBuilder content: () -> some BodyElement
    ) {
        self.content = content()
    }
    
    public func markup() -> Markup {
        let contentHTML = content.markupString()
        return Markup(contentHTML)
    }
}
