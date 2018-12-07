module OmniauthMacros
  def self.facebook_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      'provider' => 'facebook',
      'uid' => '101901487517516',
      'info' => { 'email' => 'sashamotuzko2@gmail.com', 'name' => 'Alex Motuzko', 'image' => 'http://graph.facebook.com/v2.10/101901487517516/picture' },
      'credentials' =>
        { 'token' =>
          'EAAcT2QaoKW0BAKwQrmWELZBIVwQivSoRxXidhVENeQY4ZBcAtFjc49HuwGRrrAbviJXGAtJahPhCgAkgpejkruCKfyILRZC2SQHZAJgy459U5ZAli7UHSyEd5ZAwVyvNSWXsFKeq2OhcSAisRMkdG1ZCLONIIZBeymlJJh5krveNRNohqVJCZBKJW',
          'expires' => false }
    )
  end
end
