# MatFlix
##### Matheus Tavares

It main goal is to create an app for showing upcoming movies, with a search feature that allows the user to search throughout many movies in the provider's database and see some information about them.
Screenshots given in the bottom.

- [Mandatory Features](#mandatory-features)
- [Extra Features](#extra-features)
- [Todo](#todo)
- [Requirements](#requirements)
- [Screenshots](#screenshots)
- [License](#license)

## Features

- [x] Retrieve JSON via provider's REST API
- [x] Display the poster, title, genre and release date of each movie when listing
- [x] Scroll and show more than the first 20 movies sent by each API call
- [x] Search for movies by entering a partial or full movie name
- [x] Select a specific movie to see details (name, poster image, genre, overview and release date).
- [x] Auto Layout based app, with support to Landscape and Portrait modes

## Libraries Used
- [x] RxSwift & RxCocoa - Cleaner Code & Architectures
- [x] Kingfisher - Image download, cache and handling

## Requirements

- iOS 11.0+ 
- Xcode 9.4+
- Swift 4.1+
- CocoaPods

## Screenshots
![Upcoming Movies Portrait](https://raw.githubusercontent.com/matheustavaresdev/MatFlix/development/Assets/01.png) |  ![Movie Details Portrait with big Overview](https://raw.githubusercontent.com/matheustavaresdev/MatFlix/development/Assets/03.png?raw=true "Movie Details Portrait with big Overview")
:-------------------------:|:-------------------------:

![Search List Landscape](https://raw.githubusercontent.com/matheustavaresdev/MatFlix/development/Assets/04.png?raw=true "Search List Landscape")  ![Movie Details Landscape](https://raw.githubusercontent.com/matheustavaresdev/MatFlix/development/Assets/05.png?raw=true "Movie Details Landscape")

## License

This project is available under the [BSD 2-Clause “Simplified” License](http://www.opensource.org/licenses/BSD-2-Clause):

Copyright (c) 2018, Matheus Tavares <https://github.com/matheustavaresdev/>  
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.