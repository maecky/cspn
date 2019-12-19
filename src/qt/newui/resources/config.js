/**
 * @file
 *
 * @brief       UI-Wide config
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

// @todo Library for color manipulation?
// https://github.com/Qix-/color

// Note sure if these will work..
//.import QtQuick 2.0 as QtQuick
//.import QtQuick.Window 2.2 as QtQuickWindow // for usage of 'Screen'

.pragma library

/*-------------------------------------------
  CONFIG
  ------------------------------------------*/

var color, ui, type, icons, dir;

color = {
    red: "#e80000",
    gray: {
        light:  "#e3e6e8",
        mid:    "",
        dark:   "#a4adb1"
    },
    green: {
        light:  "#00a519",
        mid:    "",
        dark:   "#008b15"
    },
    white: '#FAFAFA',
    black: '#222222'

    //  --blue: #007bff;
    //  --indigo: #6610f2;
    //  --purple: #6f42c1;
    //  --pink: #e83e8c;
    //  --red: #dc3545;
    //  --orange: #fd7e14;
    //  --yellow: #ffc107;
    //  --green: #28a745;
    //  --teal: #20c997;
    //  --cyan: #17a2b8;
    //  --white: #fff;
    //  --gray: #6c757d;
    //  --gray-dark: #343a40;
};
/*
    Keyword based colors
*/
color.brand = {
    primary: color.green.dark
};
color['primary']    = color.green.dark;
color['secondary']  = '';
color['success']    = '#28a745';
color['info']       = '#17a2b8';
color['warning']    = '#ffc107';
color['danger']     = '#dc3545';
color['light']      = '#f8f9fa';
color['dark']       = '#343a40';
/*
    Layout related dimensions such as padding
*/
ui = {
    margin: {
        xs: 5,  // Extra small
        sm: 10, // Small
        md: 16, // Medium
        lg: 24, // Large
        xl: 32  // Extra large
    },
    padding: {
        xs: 5,
        sm: 10,
        md: 16,
        lg: 24,
        xl: 32
    },
    radius: {
        xs: 2,
        sm: 3,
        md: 5,
        lg: 8,
        xl: 12
    },
};
/*
    Typography
*/
type = {
    font: 'Rubik', // +Roboto?
    base: 14, // Base font size in pixels
    h1: {
        size: 32,
        color: color.brand.primary
    },
    h2: {
        size: 26,
        color: color.black
    },
    h3: {
        size: 22,
        color: color.black
    }
};
icons = {
    // ...
    mining: 'mining-64px.svg',
    // ...
    search: 'search-24px.svg'
    // ...
};

/*
    Directory locations
*/
dir = {
    icons: 'icons/'
};
