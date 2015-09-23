//
//  Swift2OC.swift
//  meizi
//
//  Created by xmw on 15/9/14.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit

class Swift2OC: NSObject {
   
    /** 网络相册相册 */
    class  func showHost(picurl:String,image :UIImage,fromView:UIView ,fromVC:UIViewController){
        
        let pbVC = PhotoBrowser()
        /**  set album demonstration style  */
        pbVC.showType = PhotoBrowser.ShowType.ZoomAndDismissWithCancelBtnClick
        
        /**  set album style   */
        pbVC.photoType = PhotoBrowser.PhotoType.Host
        
        //forbid showing all info
        pbVC.hideMsgForZoomAndDismissWithSingleTap = true
        var models: [PhotoBrowser.PhotoModel] = []
        
        //        let titles = langType == LangType.Chinese ? titleHostCH : titleHostEN
        //        let descs = langType == LangType.Chinese ? descHostCH : descHostEN
        
        //    var cell=tableview.cellForRowAtIndexPath(indexPath) as! MyLoveViewCell
        
        //model data array
        
        
        //    for (var i=0; i<itemArray.count; i++){
        let model = PhotoBrowser.PhotoModel(hostHDImgURL: picurl, hostThumbnailImg: image, titleStr: "", descStr: "", sourceView: fromView)
        models.append(model)
        //    }
        
        /**  set models  */
        pbVC.photoModels = models
        
        pbVC.show(inVC: fromVC,index: 0)
    }
}
