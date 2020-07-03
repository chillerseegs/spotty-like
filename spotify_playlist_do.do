***** SPOTIFY PLAYLIST DATA *****
drop _all
pause on
set more off

local playlists /Users/andrewsegers/data/spotify/good_playlist.dta 
*Users/andrewsegers/data/spotify/bad_playlist.dta
*local playlists /Users/andrewsegers/data/spotify/playlist_data.dta

foreach playlist in `playlists'{
	use `playlist', clear

	cap drop dups
	duplicates tag, gen(dups)
	cap drop dups

	duplicates drop id uri track_href analysis_url, force

	save `playlist', replace

	foreach var of varlist danceability energy loudness speechiness acousticness instrumentalness liveness valence tempo {
		hist `var'
		
		sum `var'
		ret list
		
		pause graph & sum stats for `var'
		
	}
}

*Histogram(s) notes:	
	*normal distribution for the most part, centered around 0.6
	*loudness closer to 0, than to -15 --> which is louder?
	*speechiness is close to 0
	*valence is a normal distribution, centered around 0.5
	*tempo is on the lower side, some closer to 200
	
