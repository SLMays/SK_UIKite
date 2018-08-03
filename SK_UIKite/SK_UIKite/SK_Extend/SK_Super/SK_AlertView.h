//
//  SK_AlertView.h
//  SK_AlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013-2015 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

#define AlertBtnBgColor_Confirm     [UIColor colorWithHexString:@"#ffa510"]
#define AlertBtnBgColor_Cancel      [UIColor colorWithHexString:@"#ffb707"]
#define AlertBGColor                [UIColor colorWithHexString:@"#ffb707"]
#define AlertIDCardBorderColor      [UIColor colorWithHexString:@"#0c0c16"]
#define AlertTransferBorderColor    [UIColor colorWithHexString:@"#b5b5b5"]

@protocol SK_AlertViewDelegate

- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

const static CGFloat kSK_AlertViewDefaultButtonHeight       = 40;
const static CGFloat kSK_AlertViewDefaultButtonSpacerHeight = 1;
const static CGFloat kSK_AlertViewCornerRadius              = 7;
const static CGFloat kCustomIOS7MotionEffectExtent                   = 10.0;

@interface SK_AlertView : UIView<SK_AlertViewDelegate>

@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic, strong) UIView * superView;    //父类试图(放在什么上面)
//[[[UIApplication sharedApplication] windows] firstObject]

@property (nonatomic, assign) id<SK_AlertViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, retain) NSArray *buttonBgColors;
@property (nonatomic, retain) NSArray *buttonBgImgArr;
@property (nonatomic, retain) NSArray *buttonTags;
@property (nonatomic, assign) BOOL useMotionEffects;
@property (nonatomic, assign) BOOL noTouchToHideKeyBoard;


@property (copy) void (^onButtonTouchUpInside)(SK_AlertView *alertView, int buttonIndex) ;

- (id)init;

/*!
 DEPRECATED: Use the [SK_AlertView init] method without passing a parent view.
 */
- (id)initWithParentView: (UIView *)_parentView __attribute__ ((deprecated));

- (void)showInView:(id)superView;
- (void)show;
- (void)close;

- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(SK_AlertView *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;

- (CGSize)countDialogSize;
- (CGSize)countScreenSize;

@end
