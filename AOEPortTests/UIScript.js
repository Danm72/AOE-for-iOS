
var target = UIATarget.localTarget();

var appWindow = target.frontMostApp().mainWindow();

var element = target;

UIALogger.logStart("Logging element tree …");

element.logElementTree();

UIALogger.logPass();

if(appWindow.buttons()["New Game"] != null)
    appWindow.buttons()["New Game"].tap();

target.pinchOpenFromToForDuration({x:20, y:200}, {x:300, y:200}, 2);
target.pinchCloseFromToForDuration({x:500, y:500}, {x:100, y:100}, 2);


target.tap({x:20, y:200});

target.dragFromToForDuration({x:160, y:200}, {x:160, y:400}, 1);
