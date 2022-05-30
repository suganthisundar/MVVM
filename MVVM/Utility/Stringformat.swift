//
//  Stringformat.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import Foundation

extension String
{
    func replaceString(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeString(urlstring: String) -> String
    {
        let components = URLComponents(string: urlstring)
        let hostString = components!.host ?? "";
        guard let pathstring = components?.path else { return "" }
        let finalString = hostString + pathstring
        return finalString

    }
    
    func combainString(urlstring: String, type: String) -> String
    {
       
        return Strings.extraInfo + type + Strings.slash + urlstring
       
    }
}
