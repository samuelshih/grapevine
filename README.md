## Grapevine

Rails practice based on Michael Hartl's Ruby on Rail's Tutorial (3rd edition)

## run locally

In Rails 4.2.0, to get the app on http://localhost:3000, run this:

```bash
rails server -b 0.0.0.0
```

## tests

To run guard

```bash
bundle exec guard
```

If tests are being slow, might want to kill spring

```bash
spring stop
```
