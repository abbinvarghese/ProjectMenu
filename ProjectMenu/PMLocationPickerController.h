//
//  PMLocationPickerController.h
//  ProjectMenu
//
//  Created by Abbin Varghese on 15/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PMLocationPickerControllerDelegate <NSObject>

-(void)PMLocationPickerControllerFinishedWithPlace:(NSMutableDictionary*)place;

@end


@interface PMLocationPickerController : UIViewController

@property (nonatomic, strong) id <PMLocationPickerControllerDelegate> delegate;

@end
