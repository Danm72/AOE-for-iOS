typedef NS_OPTIONS(uint32_t, CNPhysicsCategory) {
    CNPhysicsCategoryBuilding = 1 << 0, // 0001 = 1
    CNPhysicsCategoryUnit = 1 << 1, // 0010 = 2
    CNPhysicsCategoryBoundary = 1 << 2, // 0001 = 4
    CNPhysicsCategorySelection = 1 << 4,

};

static const int SOUTH = 0;
static const int SOUTH_EAST = 1;
static const int EAST = 2;
static const int NORTH_EAST = 3;
static const int NORTH = 4;
static const int NORTH_WEST = 5;
static const int WEST = 6;
static const int SOUTH_WEST = 7;

static BOOL kDebugDraw = YES;
static BOOL DEBUG_MODE = NO;
static BOOL TILEMAP_MODE = YES;

