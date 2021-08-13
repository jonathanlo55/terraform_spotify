terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.0"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  auth_server = "https://oauth2.conrad.cafe"
  api_key = var.spotify_api_key
  username = "jonathanlo55@hotmail.com"
  token_id = "b93c90b1-bcb9-4a68-8f4a-7ceef67952be"
}

variable "spotify_api_key" {
  type = string
}

data "spotify_search_track" "TheKillers" {
  name   = "Somebody Told Me"
  artist = "The Killers"
  album  = "Hot Fuss"
}

data "spotify_search_track" "disturbed" {
  artist = "Disturbed"
  limit=30
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Super-Duper Playlist"
  description = "This playlist was created by Terraform"
  public      = true

  tracks = flatten([
    data.spotify_search_track.disturbed.tracks[*].id,
    data.spotify_search_track.TheKillers.tracks[*].id
  ])
}