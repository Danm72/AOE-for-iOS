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
    
    
});

SPEC_END