#import "Kiwi.h"
#import "Builder.h"
#import "TextureContainer.h"
#import "Constants.h"
#import "Unit.h"

SPEC_BEGIN(UnitSpec)

describe(@"The unit", ^{
   
    context(@"when created", ^{
        TextureContainer *obj=[TextureContainer getInstance];

        obj.builderWalk = [SKTextureAtlas atlasNamed:@"Builder_walk"];
        obj.builderIdle = [SKTextureAtlas atlasNamed:@"builder_idle"];



        Unit *builder = [Unit spriteNodeWithTexture:[obj.builderWalk textureNamed:@"builderwalking0"]];
        beforeEach(^{
//            [calculator enter:60];
//            [calculator enter:5];
        });
        afterEach(^{
//            [builder clear];
            
        });
//        it(@"throws an exception when I give a bad textureName.", ^{
//            [[theBlock(^{
//                Builder *b = [Builder spriteNodeWithTexture:[ obj.builderIdle
//                                                             textureNamed:@"??"]];
//                [b move:CGPointMake(0, 0)];
//            }) should] raiseWithName:@"RPNEmptyStackPopException"];
//        });
        
        it(@"is not nil.", ^{
            [builder shouldNotBeNil];
        });
        
        it(@"direction is north.", ^{
           int direction = [builder setDirection:CGPointMake(0, 10)];
            
            [[theValue(direction) should] equal:theValue(NORTH)];
        });
        it(@"direction is south.", ^{
            int direction = [builder setDirection:CGPointMake(0, -10)];
            
            [[theValue(direction) should] equal:theValue(SOUTH)];

        });
        it(@"direction is east.", ^{
            int direction = [builder setDirection:CGPointMake(10, 0)];
            
            [[theValue(direction) should] equal:theValue(EAST)];

        });
        
        it(@"direction is west.", ^{
            int direction = [builder setDirection:CGPointMake(-10, 0)];
            
            [[theValue(direction) should] equal:theValue(WEST)];

        });
        
//        it(@"returns 0 for top", ^{
//            [[theValue([stack top]) should] beZero];
//        });
//        it(@"throws an exception when I pop an empty stack.", ^{
//            [[theBlock(^{
//                [stack pop];
//            }) should] raiseWithName:@"RPNEmptyStackPopException"];
//        });
    });
//    context(@"after pushing 4.7 on an empty stack", ^{
//        beforeEach(^{
//            [stack push:4.7];
//        });
//        it(@"has exactly one element.", ^{
//            [[stack should] haveCountOf:1];
//        });
//        it(@"has 4.7 as top.", ^{
//            [[theValue([stack top]) should] equal:4.7 withDelta:.001];
//        });
//        it(@"returns 4.7 from pop and then is empty.", ^{
//            [[theValue([stack pop]) should] equal:4.7 withDelta:.001];
//            [[stack should] beEmpty];
//        });
   // });
});


SPEC_END