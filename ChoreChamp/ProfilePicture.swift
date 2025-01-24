//
//  ProfilePicture.swift
//  ChoreChamp
//
//  Created by Nick Chen on 11/4/24.
//

import Foundation
import SwiftUI

struct ProfilePicture: Transferable, Equatable {
  let image: Image
  let data: Data

  static var transferRepresentation: some TransferRepresentation {
    DataRepresentation(importedContentType: .image) { data in
      guard let image = ProfilePicture(data: data) else {
        throw TransferError.importFailed
      }

      return image
    }
  }
}

extension ProfilePicture {
  init?(data: Data) {
    guard let uiImage = UIImage(data: data) else {
      return nil
    }

    let image = Image(uiImage: uiImage)
    self.init(image: image, data: data)
  }
}

enum TransferError: Error {
  case importFailed
}
