#import "Kiwi.h"
#import "GameViewController.h"

SPEC_BEGIN(GameViewControllerSpec)

describe(@"GameViewControllerSpec", ^
{
    context(@"question request", ^
            {
                __block GameViewController *controller = nil;
                
                beforeEach(^
                           {
                               controller = [GameViewController mock];
                           });
                
                it(@"should conform Scene protocol", ^
                   {
                       [[controller should] conformToProtocol:@protocol(MYSceneDelegate)];
                   });
                
#ifdef SpecRequests
                it(@"should recieve receivedJSON", ^
                   {
                       NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=20";
                       
                       IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:controller urlString:questionsUrlString];
                       [[request fetchQestions] start];
                       [[[controller shouldEventuallyBeforeTimingOutAfter(3)] receive] receivedJSON:any()];
                   });
                
                it(@"should recieve fetchFailedWithError", ^
                   {
                       NSString *fakeUrl = @"asda";
                       IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:controller urlString:fakeUrl];
                       [[request fetchQestions] start];
                       [[[controller shouldEventuallyBeforeTimingOutAfter(1)] receive] fetchFailedWithError:any()];
                   });
#endif
            });
});

SPEC_END