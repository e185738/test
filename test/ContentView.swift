//
//  ContentView.swift
//  test
//
//  Created by 山城怜以 on 2021/02/20.
//  Copyright © 2021 山城怜以. All rights reserved.
//

import SwiftUI
import Foundation

// MARK: - Result
struct Result: Codable {
    let context: Context
    let id: String
    let graph: [Graph]

    enum CodingKeys: String, CodingKey {
        case context = "@context"
        case id = "@id"
        case graph = "@graph"
    }
}

// MARK: - Context
struct Context: Codable {
    let dc, foaf, v, dcterms: String
    let rdfs, cinii: String
}

// MARK: - Graph
struct Graph: Codable {
    let id: String
    let type: [String]
    let foafIsPrimaryTopicOf: FoafIsPrimaryTopicOf
    let foafName, dctermsAlternative: [DctermsAlternative]
    let dctermsHasPart: [String]
    let ciniiMemberid, ciniiOrganizationid, ciniiPrefcode, ciniiMextid: String
    let ciniiCatflag, ciniiIllflag, ciniiCopyservice, ciniiLoanservice: String
    let ciniiFaxservice, ciniiIllstatus, vFn: String
    let vAdr: VAdr
    let vTel, vFax: [VFax]
    let dcDescription: [String]

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case foafIsPrimaryTopicOf = "foaf:isPrimaryTopicOf"
        case foafName = "foaf:name"
        case dctermsAlternative = "dcterms:alternative"
        case dctermsHasPart = "dcterms:hasPart"
        case ciniiMemberid = "cinii:memberid"
        case ciniiOrganizationid = "cinii:organizationid"
        case ciniiPrefcode = "cinii:prefcode"
        case ciniiMextid = "cinii:mextid"
        case ciniiCatflag = "cinii:catflag"
        case ciniiIllflag = "cinii:illflag"
        case ciniiCopyservice = "cinii:copyservice"
        case ciniiLoanservice = "cinii:loanservice"
        case ciniiFaxservice = "cinii:faxservice"
        case ciniiIllstatus = "cinii:illstatus"
        case vFn = "v:fn"
        case vAdr = "v:adr"
        case vTel = "v:tel"
        case vFax = "v:fax"
        case dcDescription = "dc:description"
    }
}

// MARK: - DctermsAlternative
struct DctermsAlternative: Codable {
    let value: String
    let language: String?

    enum CodingKeys: String, CodingKey {
        case value = "@value"
        case language = "@language"
    }
}

// MARK: - FoafIsPrimaryTopicOf
struct FoafIsPrimaryTopicOf: Codable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
    }
}

// MARK: - VAdr
struct VAdr: Codable {
    let type, vPostalCode, vLabel: String

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case vPostalCode = "v:postal-code"
        case vLabel = "v:label"
    }
}

// MARK: - VFax
struct VFax: Codable {
    let type, value: String

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case value = "@value"
    }
}

var str1: String = ""
var str2: String = ""
var str3: String = ""
var str4: String = ""
var str5: String = ""
var str6: String = ""
var str7: String = ""

    // 遷移元
    struct ContentView: View {
        var body: some View {
            NavigationView {
                NavigationLink(destination: SubContentView()) {
                    Text("国立情報学研究所")
                }
            }.onAppear(perform: loadData)
        }
    }

    // 遷移先
    struct SubContentView: View {
        var body: some View {
            VStack(alignment: .leading){
                Text(str1)
                Text(str2)
                Text(str3)
                Text(str4)
                Text(str5)
                Text(str6)
                Text(str7)
            }
        }
        
    }


    func loadData() {
        guard let url = URL(string: "https://ci.nii.ac.jp/library/FA012943.json") else{
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data: \(String(describing: data))")

            if let data = data{
                let decorder = JSONDecoder()
                guard let result = try? decorder.decode(Result.self, from: data) else {
                    print("Json decode エラー")
                    return
                }
                print(result.graph[0].dcDescription)
                str1 = result.graph[0].dcDescription[3]
                str2 = result.graph[0].dcDescription[4]
                str3 = result.graph[0].dcDescription[8]
                str4 = result.graph[0].dcDescription[9]
                str5 = result.graph[0].dcDescription[10]
                str6 = result.graph[0].dcDescription[11]
                str7 = result.graph[0].dcDescription[12]
            }

        }.resume()

}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

