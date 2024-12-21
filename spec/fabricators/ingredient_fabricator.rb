Fabricator(:ingredient) do
  name { FFaker::BaconIpsum.words.join(' ') }
end