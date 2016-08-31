//
//  Constants.swift
//  DateTools
//
// Copyright 2015 Codewise sp. z o.o. Sp. K.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

public enum SecondsIn: UInt {
    case year = 31556900
    case month28 = 2419200
    case month29 = 2505600
    case month30 = 2592000
    case month31 = 2678400
    case week = 604800
    case day = 86400
    case hour = 3600
    case minute = 60
}
