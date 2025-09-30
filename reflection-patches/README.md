# Race Condition Fix

This directory contains patched files to fix a race condition issue where transmission clients would crash when multiple clients tried to connect simultaneously.

## Problem
The original code used a global `qBTConn` variable that was shared across all HTTP requests. When multiple transmission clients connected at the same time, they would:
1. Share the same authentication state and session cookies
2. Create race conditions in torrent list updates 
3. Corrupt cache data structures
4. Overwrite each other's session information

## Solution
The patched files eliminate the global connection variable and instead create a new qBT connection instance for each HTTP request. This ensures that:
1. Each client gets its own isolated session
2. No race conditions occur between concurrent requests
3. Authentication state is properly managed per connection
4. Cache corruption is prevented

## Files
- `main.go` - Updated HTTP handler and core functions to use per-request connections
- `main_test.go` - Updated tests to work with new connection model

## Changes Made
1. Removed global `qBTConn` variable
2. Modified `handler()` function to create new connection per request
3. Updated all function signatures to accept connection parameter
4. Added test mode support for dependency injection
5. Fixed flag parsing to work with test framework
6. Updated all tests to handle multiple auth requests per connection

This fix ensures that multiple transmission clients can connect simultaneously without causing crashes or data corruption.