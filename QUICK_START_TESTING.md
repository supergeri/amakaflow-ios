# Quick Start: Testing Workout Sync

## ✅ What's Ready

Your app is ready to test syncing workouts to:
1. **Apple Fitness** (via WorkoutKit) - iOS 18.0+ / watchOS 11.0+
2. **Apple Watch** (via WatchConnectivity) - Any iOS/watchOS version

## 🚀 Quick Test Steps

### Test 1: Save to Apple Fitness (WorkoutKit)

1. **Open the app** on your iPhone (iOS 18.0+)
2. **Tap any workout** to open details
3. **Tap "Save to Apple Fitness"** button (heart icon)
4. **Check Fitness app** - workout should appear there
5. **Check Workout app on Watch** - workout should appear there too

### Test 2: Send to Apple Watch (WatchConnectivity)

1. **Make sure Watch app is installed** on your Apple Watch
2. **Open the app** on your iPhone
3. **Tap any workout** to open details
4. **Tap "Start on Apple Watch"** button (Apple Watch icon)
5. **Open AmakaFlowWatch app** on your Watch
6. **See the workout** in the list
7. **Tap to view details** and start the workout

## 📱 Running the Apps

### iPhone App
1. Open Xcode
2. Select **AmakaFlowCompanion** scheme
3. Select your **iPhone** as the device
4. Press **Cmd+R** to run

### Watch App
1. In Xcode, select **AmakaFlowWatch Watch App** scheme
2. Select your **Apple Watch** as the device
3. Press **Cmd+R** to run

**Important:** Both apps must be running on physical devices (not simulators).

## ⚠️ Requirements

- ✅ iPhone with iOS 18.0+ (for WorkoutKit)
- ✅ Apple Watch with watchOS 11.0+ (for WorkoutKit)
- ✅ Both devices paired and nearby
- ✅ HealthKit permissions granted
- ✅ Both apps installed and signed

## 🐛 If Something Doesn't Work

1. **Check Xcode console** for error messages
2. **Verify HealthKit permissions** in Settings
3. **Make sure Watch is reachable** (unlocked, nearby)
4. **Check OS versions** match requirements
5. **See detailed guide:** `TESTING_WORKOUT_SYNC.md`

## 📝 What Just Changed

- ✅ Fixed Watch app entry point to use WorkoutListView
- ✅ Watch app now properly displays workouts received from iPhone
- ✅ Both sync methods are ready to test

## 🎯 Next Steps

1. Run both apps on physical devices
2. Test "Save to Apple Fitness" button
3. Test "Start on Apple Watch" button
4. Verify workouts appear in Fitness app
5. Verify workouts appear in Watch app
6. Try starting a workout from both devices

Good luck! 🚀

