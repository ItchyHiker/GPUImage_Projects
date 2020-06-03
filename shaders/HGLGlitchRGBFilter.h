#import "HGLBaseFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface HGLGlitchRGBFilterModel : NSObject

@property (nonatomic) NSUInteger mode;
@property (nonatomic) CGFloat intensityX;
@property (nonatomic) CGFloat intensityY;

@end

@interface HGLGlitchRGBFilter : HGLBaseFilter

- (id)initWithModel:(HGLGlitchRGBFilterModel *)model;


@end

NS_ASSUME_NONNULL_END
