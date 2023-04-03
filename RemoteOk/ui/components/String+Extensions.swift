//
//  String+Extensions.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-02.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

extension String {
    func formatHTMLString() -> NSAttributedString? {
        let htmlString = "<html>" +
        "<head>" +
        "<style>" +
        "body {" +
        "text-align: justify;" +
        "text-justify: inter-word;" +
        "}" +
        "</style>" +
        "</head>" +
        "<body>" +
        self +
        "</body></html>"
        if let data = htmlString.data(using: String.Encoding.unicode) {
            do {
                let mAttrString = try NSMutableAttributedString(data: data,
                                                                options: [.documentType : NSAttributedString.DocumentType.html.rawValue,
                                                                          .characterEncoding : String.Encoding.utf8.rawValue],
                                                                documentAttributes: nil)
                return mAttrString
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
