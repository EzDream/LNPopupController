#import "SceneDelegate.h"
#import "SettingsTableViewController.h"

@import LNTouchVisualizer;

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIWindowScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions 
{
	self.windowScene = scene;
	
#if TARGET_OS_MACCATALYST
	scene.sizeRestrictions.maximumSize = CGSizeMake(DBL_MAX, DBL_MAX);
	
	NSToolbar* toolbar = [NSToolbar new];
	toolbar.displayMode = NSToolbarDisplayModeIconOnly;
	
	scene.titlebar.toolbar = toolbar;
	
	if([self.window.rootViewController isKindOfClass:UISplitViewController.class])
	{
		UISplitViewController* split = (id)self.window.rootViewController;
		split.primaryBackgroundStyle = UISplitViewControllerBackgroundStyleSidebar;
	}
#else
	[NSUserDefaults.standardUserDefaults addObserver:self forKeyPath:PopupSettingsSlowAnimationsEnabled options:NSKeyValueObservingOptionInitial context:NULL];
	[NSUserDefaults.standardUserDefaults addObserver:self forKeyPath:PopupSettingsTouchVisualizerEnabled options:NSKeyValueObservingOptionInitial context:NULL];
	
	LNTouchConfig* rippleConfig = [LNTouchConfig rippleConfig];
	rippleConfig.fillColor = UIColor.systemPinkColor;
	scene.touchVisualizerWindow.touchRippleConfig = rippleConfig;
#endif
}

- (void)_updateWindowSpeed
{
	dispatch_async(dispatch_get_main_queue(), ^{
		self.window.layer.speed = [NSUserDefaults.standardUserDefaults boolForKey:PopupSettingsSlowAnimationsEnabled] ? 0.1 : 1.0;
	});
}

- (void)_updateTouchVisualizer
{
	self.windowScene.touchVisualizerEnabled = [NSUserDefaults.standardUserDefaults boolForKey:PopupSettingsTouchVisualizerEnabled];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
	if([keyPath isEqualToString:PopupSettingsSlowAnimationsEnabled])
	{
		[self _updateWindowSpeed];
		
		return;
	}
	
	if([keyPath isEqualToString:PopupSettingsTouchVisualizerEnabled])
	{
		[self _updateTouchVisualizer];
		
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)sceneDidDisconnect:(UIScene *)scene 
{
	// Called as the scene is being released by the system.
	// This occurs shortly after the scene enters the background, or when its session is discarded.
	// Release any resources associated with this scene that can be re-created the next time the scene connects.
	// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	
	self.windowScene = nil;
	
	[NSUserDefaults.standardUserDefaults removeObserver:self forKeyPath:PopupSettingsSlowAnimationsEnabled];
	[NSUserDefaults.standardUserDefaults removeObserver:self forKeyPath:PopupSettingsTouchVisualizerEnabled];
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
	// Called when the scene has moved from an inactive state to an active state.
	// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
	// Called when the scene will move from an active state to an inactive state.
	// This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
	// Called as the scene transitions from the background to the foreground.
	// Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
	// Called as the scene transitions from the foreground to the background.
	// Use this method to save data, release shared resources, and store enough scene-specific state information
	// to restore the scene back to its current state.
}

@end
