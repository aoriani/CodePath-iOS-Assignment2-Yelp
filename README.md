# Project 2 - *Yelp?*

**Yelp?** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **~20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
   - [x] Table rows should be dynamic height according to the content height.
   - [x] Custom cells should have the proper Auto Layout constraints.
   - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [x] The filters table should be organized into sections as in the mock.
   - [x] You can use the default UISwitch for on/off states.
   - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [x] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [x] Implement map view of restaurant results.
- [x] Filter page
   - [x] Implement a custom switch instead of the default UISwitch. **I just change the tint color red**
   - [x] Distance filter should expand as in the real Yelp app
   - [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [x]  Implement the restaurant detail page.

The following **additional** features are implemented:

- [x] Refactored the provided Yelp client to use a Builder instead of telescopic constructors.
- [x] Uses the current user location for the searches.
- [x] No results cell.
- [x] Header shows the number of results.
- [x] Supports device rotation using auto-layout to adjust for landscape.
- [x] Tapping the address on the business details screen opens Map app.
- [x] Tapping phone number on the business details screen opens options like call, add to contacts, and the like
- [x] Tapping "See more details" on the business details screen opens the Yelp page for the business on Safari. In my case because I have the original Yelp app installed, it eventually opens the business page on the Yelp app. 


Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.
2.

## Video Walkthrough

Here's a walkthrough of implemented user stories (Tap the screenshot to watch on Youtube):

[![Walktrough](http://img.youtube.com/vi/thKbapWvnmI/0.jpg)](https://youtu.be/thKbapWvnmI)

Because it uses location I decided to use my iPod Touch for the walktrough, capturing the screen with QuickTime. I didn't manage to find a tool
to convert the video to animated gif, so I uploaded the walktrough to Youtube.

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright 2016 André Oriani

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
