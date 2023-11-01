//
//  Constants.swift
//  UIComponents
//
//  Created by Matheus Valbert on 02/08/23.
//

import UIKit

public enum Colors {
    public static let lightPurple = UIColor(named: "BackgroundColor")!
    public static let purple = UIColor(named: "AccentColor")!
    public static let heavyPurple = UIColor(named: "HeavyPurple")!
}

public enum Images {
    public static let logo = UIImage(named: "Logo")!
    public static let google = UIImage(named: "Google")!
}

public enum Icons {
    public static let chats = UIImage(systemName: "bubble.left.and.bubble.right")!
    public static let chatsSelected = UIImage(systemName: "bubble.left.and.bubble.right.fill")!
    public static let profile = UIImage(systemName: "person.crop.circle")!
    public static let profileSelected = UIImage(systemName: "person.crop.circle.fill")!
    public static let friends = UIImage(systemName: "person.2")!
    public static let friendsSelected = UIImage(systemName: "person.2.fill")!
    public static let edit = UIImage(systemName: "pencil")!
    public static let send = UIImage(systemName: "paperplane.circle.fill")!
    public static let error = UIImage(systemName: "exclamationmark.circle.fill")!
}

extension Icons {
    
    public static func profile(icon: String, size: Size) -> UIImage {
        return UIImage(systemName: getIcon(icon: icon), withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: size.rawValue)))!
    }
    
    public enum Size: CGFloat {
        case small = 35
        case medium = 50
        case large = 80
    }
    
    private static func getIcon(icon: String) -> String {
        switch icon.lowercased().first {
        case "a":
            return "a.circle.fill"
        case "b":
            return "b.circle.fill"
        case "c":
            return "c.circle.fill"
        case "d":
            return "d.circle.fill"
        case "e":
            return "e.circle.fill"
        case "f":
            return "f.circle.fill"
        case "g":
            return "g.circle.fill"
        case "h":
            return "h.circle.fill"
        case "i":
            return "i.circle.fill"
        case "j":
            return "j.circle.fill"
        case "k":
            return "k.circle.fill"
        case "l":
            return "l.circle.fill"
        case "m":
            return "m.circle.fill"
        case "n":
            return "n.circle.fill"
        case "o":
            return "o.circle.fill"
        case "p":
            return "p.circle.fill"
        case "q":
            return "q.circle.fill"
        case "r":
            return "r.circle.fill"
        case "s":
            return "s.circle.fill"
        case "t":
            return "t.circle.fill"
        case "u":
            return "u.circle.fill"
        case "v":
            return "v.circle.fill"
        case "w":
            return "w.circle.fill"
        case "x":
            return "x.circle.fill"
        case "y":
            return "y.circle.fill"
        case "z":
            return "z.circle.fill"
        default:
            return "circle.fill"
        }
    }
}
