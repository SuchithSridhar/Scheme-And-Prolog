% Map Colouring
% CSCI-3137: Assignment 10
% Author: Suchith Sridhar Khajjayam
% Date: 05 Apr 2024

% Data of Nova Scotia County adjacency

adjacent(annapolis, digby).
adjacent(annapolis, kings).
adjacent(annapolis, lunenburg).
adjacent(annapolis, queens).

adjacent(antigonish, guysborough).
adjacent(antigonish, inverness).
adjacent(antigonish, pictou).

adjacent(cape_breton, richmond).                  
adjacent(cape_breton, victoria).

adjacent(colchester, cumberland).
adjacent(colchester, halifax).    
adjacent(colchester, hants).         
adjacent(colchester, pictou).         

adjacent(cumberland, colchester).

adjacent(digby, annapolis).
adjacent(digby, queens).
adjacent(digby, yarmouth).

adjacent(guysborough, antigonish).
adjacent(guysborough, halifax).
adjacent(guysborough, inverness).
adjacent(guysborough, pictou).         
adjacent(guysborough, richmond).         

adjacent(halifax, colchester).
adjacent(halifax, guysborough).
adjacent(halifax, hants).        
adjacent(halifax, lunenburg).       

adjacent(hants, colchester).
adjacent(hants, halifax).
adjacent(hants, kings).      
adjacent(hants, lunenburg).         

adjacent(inverness, antigonish).
adjacent(inverness, guysborough).
adjacent(inverness, richmond).
adjacent(inverness, victoria).

adjacent(kings, annapolis).
adjacent(kings, hants).
adjacent(kings, lunenburg).

adjacent(lunenburg, annapolis).
adjacent(lunenburg, halifax).
adjacent(lunenburg, hants).
adjacent(lunenburg, kings).
adjacent(lunenburg, queens).

adjacent(pictou, antigonish).
adjacent(pictou, colchester).
adjacent(pictou, guysborough).

adjacent(queens, annapolis).
adjacent(queens, digby).
adjacent(queens, lunenburg).
adjacent(queens, shelburne).

adjacent(richmond, cape_breton).
adjacent(richmond, guysborough).
adjacent(richmond, inverness).

adjacent(shelburne, queens).
adjacent(shelburne, yarmouth).

adjacent(victoria, cape_breton).
adjacent(victoria, inverness).

adjacent(yarmouth, digby).
adjacent(yarmouth, shelburne).

% Solution to map colouring problem

no_adjacent_same_colour(_, _, [], [], _).

no_adjacent_same_colour(County, Colour, [NextCounty|RestCounties], [NextColour|RestColours], AvailableColours) :-
    adjacent(County, NextCounty),
    member(Colour, AvailableColours),
    member(NextColour, AvailableColours),
    not(Colour = NextColour),
    no_adjacent_same_colour(County, Colour, RestCounties, RestColours, AvailableColours).

no_adjacent_same_colour(County, Colour, [NextCounty|RestCounties], [NextColour|RestColours], AvailableColours) :-
    not(adjacent(County, NextCounty)),
    member(Colour, AvailableColours),
    member(NextColour, AvailableColours),
    no_adjacent_same_colour(County, Colour, RestCounties, RestColours, AvailableColours).

colour_map(_, [], []).

colour_map(AvailableColours, [County|RestCounties], [Colour|RestColours]) :-
    colour_map(AvailableColours, RestCounties, RestColours),
    member(Colour, AvailableColours),
    no_adjacent_same_colour(County, Colour, RestCounties, RestColours, AvailableColours).
