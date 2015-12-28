require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Kafka < AbstractPhp54Extension
  init
  desc "PHP extension for Apache Kafka"
  homepage "https://github.com/EVODelavega/phpkafka/"
  url "https://github.com/EVODelavega/phpkafka/archive/828763013e858a2bada6c403861e27aced16d003.tar.gz"
  version "rev-8287630"
  sha256 "e411f4e8864d934def4c647bc047246fd9db563143f499ff39f19090effbaece"
  head "https://github.com/EVODelavega/phpkafka.git"

  depends_on "librdkafka" => :build

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-kafka"
    system "make"
    prefix.install "modules/kafka.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("kafka")
  end
end
