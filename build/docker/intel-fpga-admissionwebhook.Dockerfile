FROM golang:1.11 as builder
ARG DIR=/go/src/github.com/intel/intel-device-plugins-for-kubernetes
WORKDIR $DIR
COPY . .
RUN cd cmd/fpga_admissionwebhook; go install
RUN chmod a+x /go/bin/fpga_admissionwebhook

FROM gcr.io/distroless/base
COPY --from=builder /go/bin/fpga_admissionwebhook /usr/bin/intel_fpga_admissionwebhook
CMD ["/usr/bin/intel_fpga_admissionwebhook"]
