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
import UIKit

extension RichPopupAttachmentsViewController {
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if isEditing {
            
            let isAddAttachmentCell = tableView.cellForRow(at: indexPath) is PopupAddAttachmentCell
            let isStagedAttachmentCell = popupAttachmentsManager.attachmentAt(index: indexPath.row) is RichPopupStagedAttachment
            
            return (isAddAttachmentCell || isStagedAttachmentCell) ? indexPath : nil
        }
        else {
            return indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Can only delete attachments.
        if indexPath.section == 1, editingStyle == .delete {
            
            // Delete Attachment
            if popupAttachmentsManager.deleteAttachmentAt(index: indexPath.row) {
                
                // Update Table
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .bottom)
                tableView.endUpdates()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath) is PopupAddAttachmentCell {
            delegate?.attachmentsViewControllerDidRequestAddAttachment(self)
            return
        }
        
        if isEditing {
            if let attachment = popupAttachmentsManager.attachmentAt(index: indexPath.row) as? RichPopupStagedAttachment {
                delegate?.attachmentsViewController(self, selectedEditStagedAttachment: attachment)
            }
        }
        else {
            delegate?.attachmentsViewController(self, selectedViewAttachmentAtIndex: indexPath.row)
        }
    }
}

