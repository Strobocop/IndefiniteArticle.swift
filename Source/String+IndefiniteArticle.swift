//
//  IndefiniteArticle.swift
//
//  Copyright (c) 2016 Raymond Tang (http://raymondhytang.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public extension String {
  
  public static func indefiniteArticle(for str: String) -> String {
    let a = "a"
    let an = "an"
    
    // typeical "a" matching patterns
    //   words starting with a hard constant: domino eats a boy, a taco, a zebra
    //   words starting with a hard o: domino eats a one, a once in a lifetime offer
    //        (but an oncologist)
    //   words starting with a hard vowel: domino eats a euro, a ukulele,
    //        a uranium screw (but an urban outfitter), a useful idea, a utility belt,
    //        a unicorn, (but an uninvited guest)
    //
    let aPatterns = "^(([bcdgjkpqtuvwyz]|onc?e|onetime)$|e[uw]|uk|ur[aeiou]|use|ut([^t])|uni(l[^l])|uni[^nmd])"
    
    // specific "an" patterns
    //   words starting with a soft h: domino eats an hour, an honest man.
    //   words starting with a soft vowel: domino eats an apple, an elephant, an orange
    //   or any single letters with a soft vowel sound: domino eats an a, an a, an r, an x
    //   or anything that leads with 8: domino eats an 8, an 800 lb gorilla
    //
    let anPatterns = "^(([aefhilmnorsx]$)|(hono|honest|hour|heir|[aeiou]|8))"
    
    // Capital words or abbreviations which should likely be preceeded by an "a":
    //    Domino eata a UUID, a URL, a JOB
    //
    let uppercaseAPatterns = "^([BCDJKPQTUVWYZ][A-Z]+)"
    
    // Capital words which should likely be preceeded by an "a":
    //    Domino eats an API, an LP, an HOV
    //
    let uppercaseAnPatterns = "^([AEFHILMNORSX][A-Z]+)"
    
    do {
      var regex = try NSRegularExpression(pattern: "\\w+", options: [.caseInsensitive])
      var matches = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.characters.count))
      
      // weird case: no match (input was empty), this could happen if it's either
      // an empty string, or something non-word charactor like.
      //
      if matches.count == 0 {
        // if it's truly empty, then return empty.
        //
        if str.characters.count == 0 {
          return ""
        }
        
        // otherwise, let's defualt to an "a", i.e. "a ©".
        //
        return a
      }
      
      // Get the first word in the string
      //
      let range = matches[0].range
      let word = str.substring(with: Range<String.Index>(str.characters.index(str.startIndex, offsetBy: range.location)..<str.characters.index(str.startIndex, offsetBy: range.location + range.length)))
      
      // case sensitive matching...
      //
      regex = try NSRegularExpression(pattern: uppercaseAnPatterns, options: [])
      matches = regex.matches(in: word, options: [], range: NSRange(location: 0, length: word.characters.count))
      if matches.count > 0 {
        return an
      }
      
      regex = try NSRegularExpression(pattern: uppercaseAPatterns, options: [])
      matches = regex.matches(in: word, options: [], range: NSRange(location: 0, length: word.characters.count))
      if matches.count > 0 {
        return a
      }
      
      // insensitive...
      //
      regex = try NSRegularExpression(pattern: aPatterns, options: [.caseInsensitive])
      let aMatches = regex.matches(in: word, options: [], range: NSRange(location: 0, length: word.characters.count))
      
      regex = try NSRegularExpression(pattern: anPatterns, options: [.caseInsensitive])
      let anMatches = regex.matches(in: word, options: [], range: NSRange(location: 0, length: word.characters.count))
      
      
      // balancing the specificity of aMatches, as they could be stonger then the
      // general vowel matching of the an
      //
      if anMatches.count > 0 {
        if aMatches.count > 0 {
          return a
        }
        return an
      }
      
      // anything else gets an a.
      //
      return a
    } catch {
      return a
    }
  }
  
  func indefiniteArticle() -> String {
    return String.indefiniteArticle(for: self)
  }
  
}
