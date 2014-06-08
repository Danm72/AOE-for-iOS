#import "Kiwi.h"
#import "Builder.h"
#import "TextureContainer.h"
#import "Constants.h"
#import "Unit.h"
#import "Wall.h"

SPEC_BEGIN(BuildingSpec)

describe(@"Buildings", ^{
    SKTextureAtlas *atlas =
    [SKTextureAtlas atlasNamed:@"buildings"];
    
    context(@"when created", ^{
        it(@"should have the name", ^{
            Wall *wall = [[Wall alloc] initWithTexture:[atlas textureNamed:@"Wall"]];
            
            BOOL correctlyMade = [wall.buildType isEqualToString:@"Wall"];
            
            [[theValue(correctlyMade) should] equal:theValue(YES)];
            
        });
    });
    
    context(@"when not placed", ^{
        it(@"should not have the placed flag", ^{
            Wall *wall = [[Wall alloc] initWithTexture:[atlas textureNamed:@"Wall"]];
            
            
            [[theValue(wall.placed) should] equal:theValue(NO)];
            
        });
    });
    context(@"when placed", ^{
        it(@"should have the placed flag", ^{
            Wall *wall = [[Wall alloc] initWithTexture:[atlas textureNamed:@"Wall"]];
            wall.placed = YES;
            [[theValue(wall.placed) should] equal:theValue(YES)];
            
        });
    });
    
});

SPEC_END