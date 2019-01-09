//// Copyright 2019 Esri
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import ArcGIS

class RichPopupStagedAttachment: NSObject, RichPopupPreviewableAttachment {
    
    private(set) var attachmentData: Data
    
    private(set) var attachmentMimeType: String
    
    var name: String?
    
    init(data: Data, mimeType: String, name: String?) {
        
        self.attachmentData = data
        self.attachmentMimeType = mimeType
        self.name = name
        
        super.init()
    }
    
    /// Optionally, specify a previewItemURL is you would like this staged attachment available to QLPreviewController.
    var previewItemURL: URL?
    
    /// Complete with a UIImage if you would like an image displayed in the list of Attachments.
    func generateThumbnail(withSize: Float, scaleMode: AGSImageScaleMode, completion: @escaping (UIImage?) -> Void) {
        completion(nil)
    }
    
    /// This is only relevent if the attachmentType is `.image` type.
    var preferredSize: AGSPopupAttachmentSize = .actual
    
    /// Specify which attachment type, this will drive which attachment cell fallback image is displayed.
    var type: AGSPopupAttachmentType { return .other }
}
