#import "Kiwi.h"
#import "Builder.h"
#import "TextureContainer.h"
#import "Constants.h"
#import "Unit.h"
#import "TownCenter.h"

SPEC_BEGIN(BuilderSpec)

describe(@"The Builder", ^{
    
    context(@"when created", ^{
   TextureContainer *obj=[TextureContainer getInstance];
//        TextureContainer *obj = [TextureContainer mock];
       // [[obj stubAndReturn:theValue(@"")] idleTextures];
        //[[obj stubAndReturn:theValue(@"")] builderWalk];
//        [obj stub:@selector(builderWalk) andReturn:theValue([SKTextureAtlas atlasNamed:@"Builder_walk"])];
//        [obj stub:@selector(builderIdle) andReturn:theValue([SKTextureAtlas atlasNamed:@"builder_idle"])];
//        [obj stub:@selector(idleTextures) andReturn:theValue([NSMutableArray arrayWithCapacity:15])];
//        [obj stub:@selector(getInstance) andReturn:theValue(obj)];

//        [obj stub:@selector(builderWalk) andReturn:@"P. tigris"];

        obj.builderWalk = [SKTextureAtlas atlasNamed:@"Builder_walk"];
        obj.builderIdle = [SKTextureAtlas atlasNamed:@"builder_idle"];
        
        Builder *builder = [Builder spriteNodeWithTexture:[obj.builderWalk textureNamed:@"builderwalking0"]];
        builder.position = CGPointMake(0, 0);
        beforeEach(^{

        });
        afterEach(^{
            
        });

        it(@"is not nil.", ^{
            [builder shouldNotBeNil];
        });
        
        it(@"building correctly changes texture", ^{
            TownCenter *building = [TownCenter spriteNodeWithTexture:[obj.buildings textureNamed:@"building_site1"]];

            building.position = CGPointMake(200, 200);
            building.placed = YES;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,
                                                     (unsigned long)NULL), ^(void) {
                
                [builder createBuilding:building];
                
            });
            
            [[expectFutureValue(theValue(building.texture)) shouldEventually] equal:theValue([obj.buildings textureNamed:@"elitetowncenter"])];

        });

    });

});


SPEC_END