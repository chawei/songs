class RenameLyricsToSongs < ActiveRecord::Migration
  def self.up
    rename_table :lyrics, :songs
    rename_column :background_stories, :lyric_id, :song_id
    rename_column :notes, :lyric_id, :song_id
    rename_column :participations, :lyric_id, :song_id
    rename_column :videos, :lyric_id, :song_id
  end

  def self.down
    rename_column :videos, :song_id, :lyric_id
    rename_column :participations, :song_id, :lyric_id
    rename_column :notes, :song_id, :lyric_id
    rename_column :background_stories, :song_id, :lyric_id
    rename_table :songs, :lyrics
  end
end