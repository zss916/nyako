
#import "NativeVapView.h"
#import "UIView+VAP.h"
#import "QGVAPWrapView.h"


@interface NativeVapView : NSObject <FlutterPlatformView, VAPWrapViewDelegate>

- (instancetype)initWithFrame: (CGRect) frame
               viewIdentifier: (int64_t) viewId
                    arguments: (id _Nullable) args
                    mRegistrar: (NSObject<FlutterPluginRegistrar> *) registrar;

- (UIView*) view;

@end


@implementation NativeVapViewFactory {
    NSObject<FlutterPluginRegistrar> * _registrar;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        _registrar = registrar;
    }
    return self;
}

- (NSObject<FlutterPlatformView> *)createWithFrame: (CGRect) frame
                                    viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    return [[NativeVapView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args mRegistrar:_registrar];
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

@end

@implementation NativeVapView {
    UIView *_view;
    NSObject<FlutterPluginRegistrar> * _registrar;
    QGVAPWrapView *_wrapView;
    FlutterResult _result;
    //播放中就是ture，其他状态false
    BOOL playStatus;
    NSNumber *_mode;
}

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args mRegistrar:(NSObject<FlutterPluginRegistrar> *) registrar {
    if (self == [super init]) {
        playStatus = false;
        _view = [[UIView alloc] init];
        _registrar = registrar;
        FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:[NSString stringWithFormat:@"flutter_vap_view_%lld",viewId]
                  binaryMessenger:registrar.messenger];
    
        
        [registrar addMethodCallDelegate: self channel:channel];
        
        _mode = args[@"contentMode"];
        [self configWrapView];
    }
    return self;
}

- (void)configWrapView {
    _wrapView = [[QGVAPWrapView alloc] initWithFrame:self.view.bounds];
    _wrapView.center = self.view.center;
//        _wrapView.autoDestoryAfterFinish = YES;
    _wrapView.contentMode = _mode.intValue;
    [self.view addSubview:_wrapView];
}

#pragma mark --flutter调native回调
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    _result = result;
    
    if ([@"playPath" isEqualToString: call.method]) {
        [self playByPath:call.arguments[@"path"]];
    } else if ([@"playAsset" isEqualToString:call.method]) {
        //播放asset文件
        NSString* assetPath = [_registrar lookupKeyForAsset:call.arguments[@"asset"]];
        NSString* path = [[NSBundle mainBundle] pathForResource:assetPath ofType:nil];
        [self playByPath:path];
    } else if ([@"stop" isEqualToString:call.method]) {
        if (_wrapView) {
//            [_wrapView removeFromSuperview];
            _wrapView.hidden = YES;
        }
        playStatus = false;
    }
}

- (void)playByPath:(NSString *)path{
    //限制只能有一个视频在播放
    if (playStatus) {
        return;
    }
    
    if (_wrapView) {
        _wrapView.hidden = NO;
        _wrapView.frame = self.view.bounds;
    }
    else {
        [self configWrapView];
    }
    //修改 vapWrapView_playHWDMP4 ---> playHWDMP4
    [_wrapView playHWDMP4:path repeatCount:0 delegate:self];
}


#pragma mark VAPWrapViewDelegate--播放回调
- (void) vapWrap_viewDidStartPlayMP4:(VAPView *)container{
    playStatus = true;
}

- (void) vapWrap_viewDidFailPlayMP4:(NSError *)error{
    NSDictionary *resultDic = @{@"status":@"failure",@"errorMsg":error.description};
    _result(resultDic);
}

- (void) vapWrap_viewDidStopPlayMP4:(NSInteger)lastFrameIndex view:(VAPView *)container{
    playStatus = false;
}
    
-(void) vapWrap_viewDidFinishPlayMP4:(NSInteger)totalFrameCount view:(VAPView *)container {
    NSDictionary *resultDic = @{@"status":@"complete"};
    _result(resultDic);
    playStatus = false;
}

- (UIView*)view {
    return _view;
}

@end
