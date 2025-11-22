# Testing Follow-Along Workouts with Exercises

This guide explains how to test follow-along workouts that use exercises with video links, and sync them to both Garmin and Apple Watch.

## Overview

Follow-along workouts allow users to add Instagram, TikTok, or any video link to individual exercises in a workout. These workouts can then be:
1. **Synced to Garmin** - Workout steps are mapped to Garmin format
2. **Sent to Apple Watch** - Workout appears in the Watch app with exercise details

## Prerequisites

1. **Physical Devices Required**
   - ✅ iPhone with iOS 18.0+ (for WorkoutKit)
   - ✅ Apple Watch with watchOS 11.0+ (for WorkoutKit)
   - ✅ Garmin device (optional, for Garmin sync testing)
   - ⚠️ Simulators do NOT support HealthKit or WorkoutKit

2. **Services Running**
   - ✅ Mapper API running on `http://localhost:8001`
   - ✅ Garmin Sync API running (if testing Garmin sync)
   - ✅ Supabase database accessible

3. **App Installation**
   - Install AmakaFlow Companion on iPhone
   - Install AmakaFlowWatch on Apple Watch
   - Both apps must be signed with the same developer certificate

## Test Workout Example

Here's an example workout structure with follow-along URLs:

```json
{
  "name": "HIIT Follow-Along Workout",
  "type": "HIIT",
  "duration": 1800,
  "exercises": [
    {
      "id": "ex1",
      "name": "Jumping Jacks",
      "muscleGroups": ["cardio", "full-body"],
      "followAlongUrl": "https://www.instagram.com/reel/example1/",
      "duration": 60,
      "rest": 30
    },
    {
      "id": "ex2",
      "name": "Burpees",
      "muscleGroups": ["cardio", "full-body"],
      "followAlongUrl": "https://www.instagram.com/reel/example2/",
      "duration": 45,
      "rest": 30
    },
    {
      "id": "ex3",
      "name": "Mountain Climbers",
      "muscleGroups": ["cardio", "core"],
      "followAlongUrl": "https://www.tiktok.com/@trainer/video/example3",
      "duration": 60,
      "rest": 30
    }
  ]
}
```

## Testing Workflow

### Step 1: Create Workout with Follow-Along URLs

1. **Via Web UI (Recommended)**
   - Open the web app at `http://localhost:3000`
   - Navigate to **Workflow**
   - Add workout sources
   - In **Structure Workout** step, for each exercise:
     - Click the edit icon
     - Add a **Follow-Along Video URL** (e.g., Instagram or TikTok link)
     - Save the exercise
   - Complete validation and export

2. **Via Workout History**
   - Go to **History**
   - Open an existing workout
   - Click the edit icon next to any exercise
   - Add a follow-along URL
   - Save changes

### Step 2: Test Garmin Sync

#### Option A: Via Mapper API Directly

```bash
# First, get your workout ID from the workout history
# Then push to Garmin
curl -X POST http://localhost:8001/workouts/{workoutId}/push/garmin \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "your-user-id"
  }'
```

#### Option B: Via Web UI
- Open workout in History
- Click **"Send to Garmin"** button (if available)
- Check Garmin Connect app for the workout

#### Expected Result
- Workout appears in Garmin Connect
- Steps are mapped to Garmin format
- Exercise names and durations are preserved
- Follow-along URLs are stored but not sent to Garmin (Garmin doesn't support video links)

### Step 3: Test Apple Watch Sync

#### Via iOS App

1. **Open the iOS App**
   - Launch AmakaFlow Companion on iPhone
   - Make sure Apple Watch is paired and nearby

2. **Select Workout**
   - Tap on a workout card that has exercises with follow-along URLs
   - View workout details

3. **Send to Apple Watch**
   - Tap **"Start on Apple Watch"** button
   - Wait for confirmation

4. **Verify on Watch**
   - Open AmakaFlowWatch app on Apple Watch
   - The workout should appear in the list
   - Exercise details should be visible

5. **Start Workout**
   - Tap the workout on the Watch
   - Follow the step-by-step instructions
   - Each exercise should show its name and duration

#### Expected Result
- Workout appears in Watch app
- Exercise names and durations are displayed
- Follow-along URLs are stored in workout data (for future video playback feature)

### Step 4: Test WorkoutKit (Save to Apple Fitness)

1. **In iOS App**
   - Open workout detail view
   - Tap **"Save to Apple Fitness"** button

2. **Verify in Fitness App**
   - Open Fitness app on iPhone
   - Go to Workouts tab
   - Find your workout

3. **Start from Watch**
   - Open Workout app on Apple Watch
   - Find your workout
   - Start it

#### Expected Result
- Workout appears in Apple Fitness
- Can be started from iPhone or Watch
- Intervals follow the exercise structure
- Follow-along URLs are preserved in workout metadata

## API Endpoints for Testing

### Get Workout with Follow-Along URLs

```bash
curl http://localhost:8001/workouts/{workoutId}?userId={userId}
```

Response includes exercises with `followAlongUrl` field:

```json
{
  "success": true,
  "workout": {
    "id": "workout-123",
    "name": "HIIT Follow-Along",
    "exercises": [
      {
        "id": "ex1",
        "name": "Jumping Jacks",
        "followAlongUrl": "https://www.instagram.com/reel/example1/",
        "duration": 60
      }
    ]
  }
}
```

### Push to Garmin

```bash
curl -X POST http://localhost:8001/workouts/{workoutId}/push/garmin \
  -H "Content-Type: application/json" \
  -d '{"userId": "user-123"}'
```

### Push to Apple Watch (via iOS app)

The iOS app handles this automatically when you tap "Start on Apple Watch". The workout data is sent via WatchConnectivity.

## Troubleshooting

### Issue: Follow-along URLs not showing in workout

**Solution:**
- Verify the workout was saved with `followAlongUrl` in the exercise data
- Check Supabase database: `workouts` table → `exercises` JSON field
- Ensure the URL field is properly formatted

### Issue: Garmin sync fails

**Solution:**
- Check Garmin Sync API is running
- Verify Garmin credentials are configured
- Check mapper API logs for errors
- Ensure workout has valid exercise structure

### Issue: Apple Watch not receiving workout

**Solution:**
- Verify Watch is paired and nearby
- Check Watch app is installed
- Ensure WatchConnectivity session is activated
- Check Xcode console for WatchConnectivity errors
- Try restarting both iPhone and Watch apps

### Issue: WorkoutKit save fails

**Solution:**
- Ensure iOS 18.0+ on iPhone
- Verify watchOS 11.0+ on Apple Watch
- Check HealthKit permissions
- Ensure testing on physical device (not simulator)

## Example Test Data

### Sample Instagram URLs
- `https://www.instagram.com/reel/ABC123/`
- `https://www.instagram.com/p/XYZ789/`
- `https://www.instagram.com/tv/DEF456/`

### Sample TikTok URLs
- `https://www.tiktok.com/@trainer/video/1234567890`
- `https://vm.tiktok.com/ZMexample/`

### Sample YouTube URLs
- `https://www.youtube.com/watch?v=example123`
- `https://youtu.be/example123`

## Next Steps

1. **Video Playback Feature** (Future)
   - Implement video player in iOS app
   - Sync video playback with workout steps
   - Display current exercise video during workout

2. **Watch Video Integration** (Future)
   - Show exercise thumbnails on Watch
   - Link to video on iPhone
   - Sync timing between video and workout steps

## Related Documentation

- `TESTING_WORKOUT_SYNC.md` - General workout sync testing
- `QUICK_START_TESTING.md` - Quick testing reference
- `WORKOUT_SAVE_FEATURE.md` - Workout save functionality

