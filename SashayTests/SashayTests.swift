//
//  SashayTests.swift
//  SashayTests
//
//  Created by Райымбек Омаров on 11.07.2026.
//

import Testing
@testable  import Sashay
import Foundation
struct SashayTests {
    @Test("if page increments after 2 searchs  ")
    func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let vm = await HomeViewModel(songsService: MockSongsService())
        await vm.getSongs(text: "BTS")
        await vm.getSongs(text: "BTS")
        #expect(vm.page == 3)
        
        
    }

}
