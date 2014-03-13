#import "Kiwi.h"
#import "Building.h"
#import "Wall.h"


SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
        
        
    });
    it(@"is pretty strong", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];


    });
});

SPEC_END

SPEC_BEGIN(BuildingSpec)

describe(@"Buildings", ^{
    SKTextureAtlas *atlas =
            [SKTextureAtlas atlasNamed:@"buildings"];

    it(@"should have the name", ^{
        Wall *wall = [[Wall alloc ]initWithTexture:[atlas textureNamed:@"Wall"]];

        BOOL correctlyMade = [wall.buildType isEqualToString:@"Wall"];
        
        [[theValue(correctlyMade) should] equal:theValue(YES)];

    });
});

SPEC_END