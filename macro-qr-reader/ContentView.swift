//
//  ContentView.swift
//  macro-qr-reader
//
//  Created by Clarence on 24/10/22.
//

import CodeScanner
import SwiftUI

struct ContentView: View {
    @State private var isShowingScanner = false

    @State var encodedText: String?
    @State var decodedText: String?

    var body: some View {
        VStack(spacing: 10) {
            Button {
                isShowingScanner = true
            } label: {
                Label("Scan", systemImage: "qrcode.viewfinder")
            }

            VStack {
                Text("raw: \(encodedText ?? "")")
                Text("decoded: \(decodedText ?? "")").bold()
            }
        }
        .padding()
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Test Simulated", completion: handleScan)
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let texts = result.string.components(separatedBy: "\n")
            encodedText = texts[0]
            decodedText = encodedText?.decodeBase64() ?? "Unable to decode"
        case .failure(let error):
            print("Scanning failed: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
