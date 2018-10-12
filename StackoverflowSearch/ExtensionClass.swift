//
//  ExtensionClass.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/09.
//  Copyright © 2018 Private. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView
{
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?)
    {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString))
        {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString)
        {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil
                {
                    print("ERROR LOADING IMAGES FROM URL: \(error.debugDescription)")
                    DispatchQueue.main.async
                    {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async
                {
                    if let data = data
                    {
                        if let downloadedImage = UIImage(data: data)
                        {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

extension UIView
{
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView]
    {
        var borders = [UIView]()
        
            @discardableResult
            func addBorder(formats: String...) -> UIView
            {
                let border = UIView(frame: .zero)
                border.backgroundColor = color
                border.translatesAutoresizingMaskIntoConstraints = false
                addSubview(border)
                addConstraints(formats.flatMap {
                    NSLayoutConstraint.constraints(withVisualFormat: $0,
                                                   options: [],
                                                   metrics: ["inset": inset, "thickness": thickness],
                                                   views: ["border": border]) })
                borders.append(border)
                return border
            }
        
        
        if edges.contains(.top) || edges.contains(.all)
        {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all)
        {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all)
        {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all)
        {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
}

extension String
{
    var htmlToAttributedString: NSAttributedString?
    {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do
        {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch
        {
            return NSAttributedString()
        }
    }
    var htmlToString: String
    {
        return htmlToAttributedString?.string ?? ""
    }
}
