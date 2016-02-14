//
//  YelpConstants.swift
//  Yelp
//
//  Created by Andre Oriani on 2/13/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation


final class YelpConsts {
    
    private init() {}
    
    enum SortMode: Int {
        case BestMatched = 0, Distance, HighestRated
    }
    
    enum Distance {
        case BestMatch, TwoBlocks, SixBlocks, OneMile, FiveMiles
        
        func toString() -> String {
            switch self {
                case .BestMatch: return "Best Match"
                case .TwoBlocks: return "2 Blocks"
                case .SixBlocks: return "6 Blocks"
                case .OneMile: return "1 Mile"
                case .FiveMiles: return "5 Miles"
            }
        }
        
        func meters() -> Int {
            switch self {
                case .BestMatch: return -1
                case .TwoBlocks: return toMeters(fromMiles: NSDecimalNumber(double: 0.2)).integerValue
                case .SixBlocks: return toMeters(fromMiles: NSDecimalNumber(double: 0.6)).integerValue
                case .OneMile: return toMeters(fromMiles: NSDecimalNumber(double: 1.0)).integerValue
                case .FiveMiles: return toMeters(fromMiles: NSDecimalNumber(double: 5.0)).integerValue
            }
        }

    }
    
    let categoryDict = [
        "Afghan": "afghani",
        "African": "african",
        "American, New": "newamerican",
        "American, Traditional": "tradamerican",
        "Arabian": "arabian",
        "Argentine": "argentine",
        "Armenian": "armenian",
        "Asian Fusion": "asianfusion",
        "Asturian": "asturian",
        "Australian": "australian",
        "Austrian": "austrian",
        "Baguettes": "baguettes",
        "Bangladeshi": "bangladeshi",
        "Barbeque": "bbq",
        "Basque": "basque",
        "Bavarian": "bavarian",
        "Beer Garden": "beergarden",
        "Beer Hall": "beerhall",
        "Beisl": "beisl",
        "Belgian": "belgian",
        "Bistros": "bistros",
        "Black Sea": "blacksea",
        "Brasseries": "brasseries",
        "Brazilian": "brazilian",
        "Breakfast & Brunch": "breakfast_brunch",
        "British": "british",
        "Buffets": "buffets",
        "Bulgarian": "bulgarian",
        "Burgers": "burgers",
        "Burmese": "burmese",
        "Cafes": "cafes",
        "Cafeteria": "cafeteria",
        "Cajun/Creole": "cajun",
        "Cambodian": "cambodian",
        "Canadian": "New)",
        "Canteen": "canteen",
        "Caribbean": "caribbean",
        "Catalan": "catalan",
        "Chech": "chech",
        "Cheesesteaks": "cheesesteaks",
        "Chicken Shop": "chickenshop",
        "Chicken Wings": "chicken_wings",
        "Chilean": "chilean",
        "Chinese": "chinese",
        "Comfort Food": "comfortfood",
        "Corsican": "corsican",
        "Creperies": "creperies",
        "Cuban": "cuban",
        "Curry Sausage": "currysausage",
        "Cypriot": "cypriot",
        "Czech": "czech",
        "Czech/Slovakian": "czechslovakian",
        "Danish": "danish",
        "Delis": "delis",
        "Diners": "diners",
        "Dumplings": "dumplings",
        "Eastern European": "eastern_european",
        "Ethiopian": "ethiopian",
        "Fast Food": "hotdogs",
        "Filipino": "filipino",
        "Fish & Chips": "fishnchips",
        "Fondue": "fondue",
        "Food Court": "food_court",
        "Food Stands": "foodstands",
        "French": "french",
        "French Southwest": "sud_ouest",
        "Galician": "galician",
        "Gastropubs": "gastropubs",
        "Georgian": "georgian",
        "German": "german",
        "Giblets": "giblets",
        "Gluten-Free": "gluten_free",
        "Greek": "greek",
        "Halal": "halal",
        "Hawaiian": "hawaiian",
        "Heuriger": "heuriger",
        "Himalayan/Nepalese": "himalayan",
        "Hong Kong Style Cafe": "hkcafe",
        "Hot Dogs": "hotdog",
        "Hot Pot": "hotpot",
        "Hungarian": "hungarian",
        "Iberian": "iberian",
        "Indian": "indpak",
        "Indonesian": "indonesian",
        "International": "international",
        "Irish": "irish",
        "Island Pub": "island_pub",
        "Israeli": "israeli",
        "Italian": "italian",
        "Japanese": "japanese",
        "Jewish": "jewish",
        "Kebab": "kebab",
        "Korean": "korean",
        "Kosher": "kosher",
        "Kurdish": "kurdish",
        "Laos": "laos",
        "Laotian": "laotian",
        "Latin American": "latin",
        "Live/Raw Food": "raw_food",
        "Lyonnais": "lyonnais",
        "Malaysian": "malaysian",
        "Meatballs": "meatballs",
        "Mediterranean": "mediterranean",
        "Mexican": "mexican",
        "Middle Eastern": "mideastern",
        "Milk Bars": "milkbars",
        "Modern Australian": "modern_australian",
        "Modern European": "modern_european",
        "Mongolian": "mongolian",
        "Moroccan": "moroccan",
        "New Zealand": "newzealand",
        "Night Food": "nightfood",
        "Norcinerie": "norcinerie",
        "Open Sandwiches": "opensandwiches",
        "Oriental": "oriental",
        "Pakistani": "pakistani",
        "Parent Cafes": "eltern_cafes",
        "Parma": "parma",
        "Persian/Iranian": "persian",
        "Peruvian": "peruvian",
        "Pita": "pita",
        "Pizza": "pizza",
        "Polish": "polish",
        "Portuguese": "portuguese",
        "Potatoes": "potatoes",
        "Poutineries": "poutineries",
        "Pub Food": "pubfood",
        "Rice": "riceshop",
        "Romanian": "romanian",
        "Rotisserie Chicken": "rotisserie_chicken",
        "Rumanian": "rumanian",
        "Russian": "russian",
        "Salad": "salad",
        "Sandwiches": "sandwiches",
        "Scandinavian": "scandinavian",
        "Scottish": "scottish",
        "Seafood": "seafood",
        "Serbo Croatian": "serbocroatian",
        "Signature Cuisine": "signature_cuisine",
        "Singaporean": "singaporean",
        "Slovakian": "slovakian",
        "Soul Food": "soulfood",
        "Soup": "soup",
        "Southern": "southern",
        "Spanish": "spanish",
        "Steakhouses": "steak",
        "Sushi Bars": "sushi",
        "Swabian": "swabian",
        "Swedish": "swedish",
        "Swiss Food": "swissfood",
        "Tabernas": "tabernas",
        "Taiwanese": "taiwanese",
        "Tapas Bars": "tapas",
        "Tapas/Small Plates": "tapasmallplates",
        "Tex-Mex": "tex-mex",
        "Thai": "thai",
        "Traditional Norwegian": "norwegian",
        "Traditional Swedish": "traditional_swedish",
        "Trattorie": "trattorie",
        "Turkish": "turkish",
        "Ukrainian": "ukrainian",
        "Uzbek": "uzbek",
        "Vegan": "vegan",
        "Vegetarian": "vegetarian",
        "Venison": "venison",
        "Vietnamese": "vietnamese",
        "Wok": "wok",
        "Wraps": "wraps",
        "Yugoslav": "yugoslav"
    ]
}