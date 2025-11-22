# Testing Workout Sync to Apple Watch & Apple Fitness

This guide will help you test syncing workouts to Apple Watch and Apple Fitness.

## Prerequisites

### Required Setup

1. **Physical Devices Required**
   - ✅ iPhone with iOS 18.0+ (for WorkoutKit)
   - ✅ Apple Watch with watchOS 11.0+ (for WorkoutKit)
   - ⚠️ Simulators do NOT support HealthKit or WorkoutKit

2. **Device Pairing**
   - iPhone and Apple Watch must be paired
   - Both devices should be unlocked and nearby
   - Bluetooth must be enabled

3. **App Installation**
   - Install AmakaFlow Companion on iPhone
   - Install AmakaFlowWatch on Apple Watch
   - Both apps must be signed with the same developer certificate

4. **Permissions**
   - HealthKit permissions granted on both devices
   - Watch Connectivity permissions (automatic)

## Testing WorkoutKit (Save to Apple Fitness)

### What This Does

When you tap **"Save to Apple Fitness"**, the workout is saved to Apple's WorkoutKit, which:
- Appears in the **Fitness app** on iPhone
- Appears in the **Workout app** on Apple Watch
- Can be started from either device
- Syncs workout data to HealthKit

### Steps to Test

1. **Open the App**
   - Launch AmakaFlow Companion on your iPhone
   - Make sure you're on iOS 18.0+

2. **Select a Workout**
   - Tap on any workout card to open the detail view
   - You should see the workout details with intervals

3. **Save to Apple Fitness**
   - Tap the **"Save to Apple Fitness"** button (heart icon)
   - Wait for the success confirmation
   - Button should change to "Saved to Apple Fitness" with a checkmark

4. **Verify in Fitness App**
   - Open the **Fitness app** on your iPhone
   - Go to the **Workouts** tab
   - Look for your workout in the list
   - It should show the workout name and details

5. **Verify on Apple Watch**
   - Open the **Workout app** on your Apple Watch
   - Scroll to find your workout
   - You should be able to start it from the watch

6. **Start the Workout**
   - From iPhone: Open Fitness app → Tap your workout → Start
   - From Watch: Open Workout app → Find your workout → Start
   - The workout should follow the intervals you defined

### Expected Console Output

```
⌚️ Starting WorkoutKit session: [Workout Name]
```

### Troubleshooting

**Issue: "WorkoutKit requires iOS 18.0+" message**
- ✅ Make sure your iPhone is running iOS 18.0 or later
- Check: Settings → General → About → Software Version

**Issue: Button doesn't work / No error shown**
- Check Xcode console for errors
- Verify WorkoutKitSync package is properly linked
- Make sure you're testing on a physical device (not simulator)

**Issue: Workout doesn't appear in Fitness app**
- Wait a few seconds for sync
- Force quit and reopen Fitness app
- Check HealthKit permissions in Settings → Privacy & Security → Health

## Testing Watch Connectivity (Start on Apple Watch)

### What This Does

When you tap **"Start on Apple Watch"**, the workout is sent to the Watch app via WatchConnectivity, which:
- Sends workout data to the AmakaFlowWatch app
- Appears in the Watch app's workout list
- Can be started directly from the Watch app

### Steps to Test

1. **Ensure Watch App is Installed**
   - Make sure AmakaFlowWatch is installed on your Apple Watch
   - Open the Watch app on your iPhone
   - Verify AmakaFlowWatch appears in "My Watch" section

2. **Open the App**
   - Launch AmakaFlow Companion on your iPhone
   - Tap on any workout card

3. **Send to Watch**
   - Tap the **"Start on Apple Watch"** button (Apple Watch icon)
   - Wait for the success confirmation
   - Button should change to "Workout Sent — Ready on Watch"

4. **Verify on Watch**
   - Open the **AmakaFlowWatch** app on your Apple Watch
   - You should see the workout in the list
   - Tap on it to view details

5. **Start from Watch**
   - Tap the workout in the Watch app
   - Tap "Start Workout" (if implemented)
   - The workout should begin

### Expected Console Output

```
⌚️ WCSession activated successfully
⌚️ Sent workout to watch: [Workout Name]
⌚️ Watch received workout: [Workout Name]
```

### Troubleshooting

**Issue: "Watch is not reachable"**
- ✅ Make sure Apple Watch is unlocked
- ✅ Make sure Apple Watch is nearby (Bluetooth range)
- ✅ Make sure both devices have Bluetooth enabled
- ✅ Try opening the Watch app on the Watch first

**Issue: "Watch app is not installed"**
- Install AmakaFlowWatch on your Apple Watch
- In Xcode: Select the Watch target → Run on your Watch device
- Or install via Watch app on iPhone

**Issue: Workout doesn't appear on Watch**
- Check Watch app console for errors
- Verify WatchConnectivity session is activated
- Try sending again after ensuring Watch is reachable

## Testing Both Methods Together

You can test both methods for the same workout:

1. **Save to Apple Fitness** (WorkoutKit)
   - Workout appears in Fitness app
   - Can start from iPhone or Watch

2. **Send to Watch** (WatchConnectivity)
   - Workout appears in AmakaFlowWatch app
   - Can start from Watch app

Both methods work independently and can be used together.

## Debugging Tips

### Enable Verbose Logging

The app already includes console logging. Watch for these messages:

**WorkoutKit:**
- `⌚️ Starting WorkoutKit session: [name]`
- `⌚️ Failed to start WorkoutKit session: [error]`

**WatchConnectivity:**
- `⌚️ WCSession activated successfully`
- `⌚️ Sent workout to watch: [name]`
- `⌚️ Watch received workout: [name]`
- `⌚️ Watch is not reachable`
- `⌚️ Watch app is not installed`

### Check HealthKit Permissions

1. Settings → Privacy & Security → Health
2. Find "AmakaFlow Companion"
3. Ensure all required permissions are enabled

### Check Watch Connectivity Status

In Xcode console, look for:
- `⌚️ WCSession activation state: 2` (activated)
- `⌚️ Watch reachability changed: true/false`

## Common Issues & Solutions

### Issue: "Cannot find 'WorkoutKitSync' in scope"

**Solution:**
1. Clean build folder (Cmd+Shift+K)
2. Verify WorkoutKitSync package is added in Xcode
3. Check Package Dependencies in project settings
4. Rebuild the project

### Issue: Workout appears but won't start

**Solution:**
1. Check HealthKit permissions
2. Verify workout intervals are valid
3. Check console for WorkoutKit errors
4. Try a simpler workout (just warmup + cooldown)

### Issue: Watch app crashes when receiving workout

**Solution:**
1. Check Watch app console for crash logs
2. Verify Workout model is Codable
3. Check for memory issues with large workouts
4. Try with a simpler workout first

## Next Steps After Testing

Once both methods work:

1. ✅ Test with different workout types (running, strength, etc.)
2. ✅ Test with complex intervals (repeats, multiple steps)
3. ✅ Test scheduling workouts for future dates
4. ✅ Test starting workouts from both iPhone and Watch
5. ✅ Verify workout data syncs to HealthKit after completion

## Success Criteria

✅ **WorkoutKit Test:**
- Workout appears in Fitness app
- Workout appears in Workout app on Watch
- Can start workout from either device
- Workout follows defined intervals

✅ **WatchConnectivity Test:**
- Workout sent to Watch app successfully
- Workout appears in AmakaFlowWatch app
- Can view workout details on Watch
- Can start workout from Watch (if implemented)

## Need Help?

If you encounter issues:
1. Check Xcode console for error messages
2. Verify all prerequisites are met
3. Check HealthKit permissions
4. Ensure both devices are on required OS versions
5. Review the troubleshooting sections above

