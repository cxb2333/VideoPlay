//
//  ViewController.m
//  两个视频播放
//
//  Created by mac on 17/4/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Foundation/Foundation.h>
#import "VideoInfo.h"
#import "AVPlayerBgView.h"

@interface ViewController () <AVPlayerBgViewDelegate>
{
    AVPlayerLayer *playerLayer1;
    AVPlayerLayer *playerLayer2;
}

@property (nonatomic, weak) AVPlayerBgView *playerBgView1;
@property (nonatomic, weak) AVPlayerBgView *playerBgView2;
@property (nonatomic, strong) AVPlayer *player1;
@property (nonatomic, strong) AVPlayer *player2;
@property (nonatomic, strong) NSMutableArray *videoInfos;

@end

@implementation ViewController

-(AVPlayer *)player1{
    if (!_player1) {
        AVPlayer *player = [[AVPlayer alloc]init];
        _player1 = player;
    }
    return _player1;
}
-(AVPlayer *)player2{
    if (!_player2) {
        AVPlayer *player = [[AVPlayer alloc]init];
        player.volume = 0;
        _player2 = player;
    }
    return _player2;
}

- (void)viewWillAppear:(BOOL)animated{
    [self layoutSubView];
    [self setupPlayerLayer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _videoInfos = [NSMutableArray array];
    [self loadVideos];
    
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

- (void)layoutSubView{
    AVPlayerBgView *playerBgView1 = [[AVPlayerBgView alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, kScreenH)];
    playerBgView1.delegate = self;
    playerBgView1.tag = 0;
    playerBgView1.backgroundColor = [UIColor blackColor];
    _playerBgView1 = playerBgView1;
    [self.view addSubview:playerBgView1];
    
    AVPlayerBgView *playerBgView2 = [[AVPlayerBgView alloc]initWithFrame:CGRectMake(playerBgView1.right, 0, kScreenW/2, playerBgView1.height)];
    playerBgView2.delegate = self;
    playerBgView2.tag = 1;
    playerBgView2.backgroundColor = [UIColor blackColor];
    _playerBgView2 = playerBgView2;
    [self.view addSubview:playerBgView2];
    
    // 开始按钮
    UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenH-30, 50, 30)];
    startButton.centerX = kScreenW/2;
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton setTitle:@"停止" forState:UIControlStateSelected];
    [startButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:startButton];
}

#pragma mark - //－－－－－AVPlayerBgViewDelegate－－－－－
- (void)avPlayerBgView:(AVPlayerBgView *)avPlayerBgView distanceFromCenter:(float)distance{
    if (avPlayerBgView.tag == 0) {
        _playerBgView2.x = kScreenW/2 + distance;
    }else{
        _playerBgView1.x = - distance;
    }
}

- (void)setupPlayerLayer{
    playerLayer1 = [AVPlayerLayer playerLayerWithPlayer:self.player1];
    playerLayer1.frame = _playerBgView1.bounds;
//    playerLayer1.videoGravity = AVLayerVideoGravityResize;//视频填充模式
    [_playerBgView1.layer addSublayer:playerLayer1];
    
    playerLayer2 = [AVPlayerLayer playerLayerWithPlayer:self.player2];
    playerLayer2.frame = _playerBgView2.bounds;
//    playerLayer2.videoGravity = AVLayerVideoGravityResize;//视频填充模式
    [_playerBgView2.layer addSublayer:playerLayer2];
}

- (void)startButtonClick:(UIButton *)button{
    if (button.selected == NO) {
        button.selected = YES;
        VideoInfo *videoInfo = self.videoInfos[0];
        [self playWithUrl:videoInfo.videoURL];
    }else{
        button.selected = NO;
        [_player1 pause];
        [_player2 pause];
    }
    
}

- (void)playWithUrl:(NSURL *)url{
    AVPlayerItem *playerItem1 = [[AVPlayerItem alloc]initWithURL:url];
    [_player1 replaceCurrentItemWithPlayerItem:playerItem1];
    [_player1 play];
    AVPlayerItem *playerItem2 = [[AVPlayerItem alloc]initWithURL:url];
    [_player2 replaceCurrentItemWithPlayerItem:playerItem2];
    [_player2 play];
    
}

- (void)loadVideos{
    NSMutableArray *urls = [NSMutableArray array];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    __weak typeof(self) weakSelf = self;
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    if (![urls containsObject:result.defaultRepresentation.url]) {
                        VideoInfo *videoInfo = [[VideoInfo alloc] init];
                        // videoInfo.videoURL = [result valueForProperty:ALAssetPropertyAssetURL];
                        videoInfo.videoURL = result.defaultRepresentation.url;
                        videoInfo.thumbnail = [UIImage imageWithCGImage:result.thumbnail];
                        NSNumber *numberValue = [result valueForProperty:ALAssetPropertyDuration];
                        videoInfo.duration = numberValue.intValue;
                        videoInfo.name = [self getFormatedDateStringOfDate:[result valueForProperty:ALAssetPropertyDate]];
                        videoInfo.size = result.defaultRepresentation.size; //Bytes
                        videoInfo.format = [result.defaultRepresentation.filename pathExtension];
                        AVAsset *asset = [AVAsset assetWithURL:videoInfo.videoURL];
                        NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
                        if([tracks count] > 0) {
                            AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
                            videoInfo.width = videoTrack.naturalSize.width;
                            videoInfo.height = videoTrack.naturalSize.height;
                        }
                        [weakSelf.videoInfos addObject:videoInfo];
                        [urls addObject:videoInfo.videoURL];
//                        NSLog(@"%@",videoInfo.videoURL);
                    }
                }
            }];
        } else {
            //没有更多的group时，即可认为已经加载完成。
            for (VideoInfo *videoInfo in weakSelf.videoInfos) {
                NSLog(@"%@",videoInfo.videoURL);
            }
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Failed.");
    }];
}
-(NSString*)getFormatedDateStringOfDate:(NSDate*)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"]; //注意时间的格式：MM表示月份，mm表示分钟，HH用24小时制，小hh是12小时制。
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
