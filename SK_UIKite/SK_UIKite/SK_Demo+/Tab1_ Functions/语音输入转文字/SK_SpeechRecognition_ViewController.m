//
//  SK_SpeechRecognition_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/25.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_SpeechRecognition_ViewController.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

#define LoadingText @"正在录音。。。"

@interface SK_SpeechRecognition_ViewController ()<SFSpeechRecognizerDelegate>
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) UIButton * lanuageBtn;
@property (nonatomic,strong) UIButton * dictationBtn;

@property (nonatomic,strong) SFSpeechRecognizer *speechRecognizer;
@property (nonatomic,strong) AVAudioEngine *audioEngine;
@property (nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;
@property (nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@end

@implementation SK_SpeechRecognition_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [SFSpeechRecognizer  requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    weakSelf.dictationBtn.enabled = NO;
                    [weakSelf.dictationBtn setTitle:@"语音识别未授权" forState:UIControlStateDisabled];
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    weakSelf.dictationBtn.enabled = NO;
                    [weakSelf.dictationBtn setTitle:@"用户未授权使用语音识别" forState:UIControlStateDisabled];
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    weakSelf.dictationBtn.enabled = NO;
                    [weakSelf.dictationBtn setTitle:@"语音识别在这台设备上受到限制" forState:UIControlStateDisabled];
                    
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    weakSelf.dictationBtn.enabled = YES;
                    [weakSelf.dictationBtn setTitle:@"开始听写" forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
            
        });
    }];
}
-(void)initUI
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, 350)];
    _textView.bColor = RandomColor;
    _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textView.textColor = [UIColor blackColor];
    [self.view addSubview:_textView];
    
    _dictationBtn = [UIButton initWithFrame:CGRectMake(0, NOHAVE_TABBAR_HEIGHT-45, WIDTH_IPHONE, 45) Title:@"开始听写" TitleColor:[UIColor whiteColor] BgColor:[UIColor blueColor] Image:nil BgImage:nil Target:self Action:@selector(DictationAction:) ForControlEvents:UIControlEventTouchUpInside Tag:1];
    [self.view addSubview:_dictationBtn];
}


#pragma mark - property
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}
- (SFSpeechRecognizer *)speechRecognizer{
    if (!_speechRecognizer) {
        //要为语音识别对象设置语言，这里设置的是中文
        NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        _speechRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}


-(void)DictationAction:(UIButton *)btn
{
    if (self.audioEngine.isRunning) {
        [self endRecording];
        [self.dictationBtn setTitle:@"正在停止" forState:UIControlStateDisabled];
        [self.dictationBtn setBackgroundColor:[UIColor blueColor]];
    }
    else{
        [self startRecording];
        [self.dictationBtn setTitle:@"停止录音" forState:UIControlStateNormal];
        [self.dictationBtn setBackgroundColor:[UIColor redColor]];
    }
}


- (void)endRecording{
    [self.audioEngine stop];
    if (_recognitionRequest) {
        [_recognitionRequest endAudio];
    }
    
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    self.dictationBtn.enabled = NO;
    
    if ([self.textView.text isEqualToString:LoadingText]) {
        self.textView.text = @"";
    }
}
- (void)startRecording{
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognitionRequest, @"请求初始化失败");
    _recognitionRequest.shouldReportPartialResults = YES;
    __weak typeof(self) weakSelf = self;
    _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL isFinal = NO;
        if (result) {
            strongSelf.textView.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            strongSelf.recognitionTask = nil;
            strongSelf.recognitionRequest = nil;
            strongSelf.dictationBtn.enabled = YES;
            [strongSelf.dictationBtn setTitle:@"开始录音" forState:UIControlStateNormal];
        }
    }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
    [inputNode removeTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.recognitionRequest) {
            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    self.textView.text = LoadingText;
}
#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        self.dictationBtn.enabled = YES;
        [self.dictationBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    }
    else{
        self.dictationBtn.enabled = NO;
        [self.dictationBtn setTitle:@"语音识别不可用" forState:UIControlStateDisabled];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
