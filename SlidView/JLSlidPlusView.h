

#import <UIKit/UIKit.h>

@interface JLSlidPlusView : UIView

@property (nonatomic, strong) void(^MoveEndCompletionBlock)(NSString *title);

/**
 *  Setup maxNum、minNum 、stepLength .call this method after make constains or set frame;
 *
 *  @param max        maxNum of SlidView
 *  @param min        minNum of SlidView
 *  @param stepLength everytime move length
 */
- (void)setMax:(NSInteger)max Min:(NSInteger)min stepLength:(NSInteger)stepLength;

/**
 *  get a NSArray ,contain  maxNum and minNum
 *
 *  @return NSArray
 */
- (NSArray *)getConfirmRangeArr;
- (void)resetRange:(NSArray *)rangeArr;
@end
