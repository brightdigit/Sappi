import ArgumentParser

enum RatioFormat: String, ExpressibleByArgument {
  case percent
  case ratio
  case `default`
  case percentTotal
}
