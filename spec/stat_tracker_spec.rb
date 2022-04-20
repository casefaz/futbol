require './lib/stat_tracker'


RSpec.describe StatTracker do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
    @stat_tracker = StatTracker.from_csv(@locations)

  end

    it 'exists and has attributes' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'can call #from_csv on self' do
        expect(@stat_tracker.games.count).to eq(20)
        expect(@stat_tracker.teams.count).to eq(32)
        expect(@stat_tracker.game_teams.count).to eq(40)
    end

    # xit 'can load collections' do
    #
    #   expect(stat_tracker.load_collections(locations)).to eq({
    #     games => CSV.read(locations[:games], headers:true,
    #        header_converters: :symbol),
    #     teams =>,
    #     game_teams =>
    #     })
    #   collections is the key with the data as the value so that
    # end
    describe 'League Statistics' do
      it '#count_of_teams can count teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
      end

      it '#best_offense finds team with the best offense' do
        expect(@stat_tracker.best_offense).to eq(["Atlanta United",
           "Orlando City SC", "Portland Timbers", "San Jose Earthquakes"])
      end

      it '#team_name_helper finds team name via team_id' do
        expect(@stat_tracker.team_name_helper("3")).to eq("Houston Dynamo")
      end



    end

    describe 'Team Statistics' do
      it '#team_info can put team info into a hash' do 
        expected = {
          "team_id" => "1",
          "franchise_id" => "23",
          "team_name" => "Atlanta United",
          "abbreviation" => "ATL",
          "link" => "/api/v1/teams/1"
        }

        expect(@stat_tracker.team_info("1")).to eq(expected)
      end

      it 'can identify the season through the game id' do
        expect(@stat_tracker.season_games("2012030221")).to eq("20122013")
      end

      it '#best_season can determine the best season for a team' do
        expect(@stat_tracker.best_season("24")).to eq("20122013")
      end

      it '#worst_season can determine the best season for a team' do 
        expect(@stat_tracker.worst_season("24")).to eq("20132014")
      end

      it '#average_win_percentage can determine the average wins of all games for a team' do 
        expect(@stat_tracker.average_win_percentage("3")).to eq(0.0)
      end

      it '#most_goals_scored can find the highest number of goals a team has scored in a game' do
        expect(@stat_tracker.most_goals_scored("3")).to eq(2)
      end

      it '#fewest_goals_scored can find the lowest number of goals a team has scored in a game' do 
        expect(@stat_tracker.fewest_goals_scored("3")).to eq(1)
      end 

      it '#favorite_opponent can produce the name of the team with the lowest win percentage against another team' do 
        expect(@stat_tracker.favorite_opponent("24")).to eq("Chicago Fire")
      end

      it '#rival can produce the name that has the highest win percentage against the given team' do
        expect(@stat_tracker.rival("24")).to eq("Portland Timbers")
      end
    end
end
