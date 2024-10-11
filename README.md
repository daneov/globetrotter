# Globetrotter

This app consumes information from https://restcountries.com and allows you
to learn a bit more about all the different countries!

## How to run

1. Clone this repository
2. Open the `Globetrotter.xcodeproj` file with Xcode
3. Run it on the Simulator or on your iPhone

    - Tip: Keep in mind that you'll have to change the signing settings if you wish to run it on your phone

## Structure

1. Entrypoint: GlobetrotterApp.swift
2. Views: Globetrotter/views
3. ViewModels: Globetrotter/ViewModels
4. Models: Globetrotter/Models

## Design choices

This app uses an MVVM architecture to separate View- from business-logic,
and leverages a Composition root to define all the dependencies present
in the application. 
This allows for easy reference and one location in our
code that requires the knowledge to construct them.
knowledge to create those dependencies.

No UI tests were written due to time-constraints, but a decent level of
coverage was achieved by means of the new Swift Testing framework.
