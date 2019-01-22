require_relative '../lib/crypto_currencies'

describe "the crypto_scrapper method" do
    it "should return hash, and hash is not nil" do
      expect(crypto_scrapper).not_to be_nil
    end
  end
  