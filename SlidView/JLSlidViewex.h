

#import <UIKit/UIKit.h>

@interface JLSlidViewex : UIView

@property (nonatomic, strong) void(^ChangeLabelValueBlock)(NSInteger leftValue,NSInteger rightValue);

- (void)setLineHeight:(CGFloat)lineHeight pointViewW:(CGFloat)pointViewW pointViewH:(CGFloat)pointViewH;
- (void)setMax:(CGFloat)max Min:(CGFloat)min stepLength:(CGFloat)stepLength;
- (NSArray *)getConfirmRangeArr;
- (void)resetRange:(NSArray *)rangeArr;
@end
