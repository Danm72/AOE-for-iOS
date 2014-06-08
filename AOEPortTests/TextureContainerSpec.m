//
//  TextureContainerSpec.m
//  AOEPort
#import "Kiwi.h"
#import "TextureContainer.h"
#import "Builder.h"


SPEC_BEGIN(TextureContainerSpec)
TextureContainer *obj1=[TextureContainer getInstance];

obj1.builderWalk = [SKTextureAtlas atlasNamed:@"Builder_walk"];
obj1.builderIdle = [SKTextureAtlas atlasNamed:@"builder_idle"];

beforeEach(^{
    
});
afterEach(^{
    
});

describe(@"The Texture Container", ^{
    it(@"when re-created should have the same contents", ^{
        TextureContainer *obj2=[TextureContainer getInstance];

        [[theValue(obj2.builderWalk) should] equal:theValue(obj1.builderWalk)];
    });
    it(@"when re-created should not mix up atlases", ^{
        TextureContainer *obj3=[TextureContainer getInstance];

        [[theValue(obj3.builderWalk) shouldNot] equal:theValue(obj1.builderIdle)];
    });
    it(@"should store idle textures", ^{
        Builder *builder = [Builder spriteNodeWithTexture:[obj1.builderWalk textureNamed:@"builderwalking0"]];

        [[theValue([obj1.idleTextures count]) shouldNot] beLessThanOrEqualTo:theValue(0)];
    });
    
    it(@"should not discard textures", ^{
        Builder *builder = [Builder spriteNodeWithTexture:[obj1.builderWalk textureNamed:@"builderwalking0"]];
        [builder move:CGPointMake(9, 9)]; //Loads movement textures, upon memory warning some cached elements may be dumped
        [[theValue([obj1.idleTextures count]) shouldNot] beLessThanOrEqualTo:theValue(0)];
    });
});

SPEC_END

